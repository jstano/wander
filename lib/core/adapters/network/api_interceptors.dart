// lib/core/adapters/network/api_interceptors.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ============================================================================
// 1. LOGGING INTERCEPTOR - Log requests/responses (dev only)
// ============================================================================
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('╔════════════════════════════════════════════════════════════');
      print('║ REQUEST');
      print('╠════════════════════════════════════════════════════════════');
      print('║ Method: ${options.method}');
      print('║ URL: ${options.uri}');
      print('║ Headers: ${options.headers}');
      print('║ Query Params: ${options.queryParameters}');
      print('║ Body: ${options.data}');
      print('╚════════════════════════════════════════════════════════════');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('╔════════════════════════════════════════════════════════════');
      print('║ RESPONSE');
      print('╠════════════════════════════════════════════════════════════');
      print('║ Status Code: ${response.statusCode}');
      print('║ URL: ${response.requestOptions.uri}');
      print('║ Headers: ${response.headers}');
      print('║ Body: ${response.data}');
      print('╚════════════════════════════════════════════════════════════');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('╔════════════════════════════════════════════════════════════');
      print('║ ERROR');
      print('╠════════════════════════════════════════════════════════════');
      print('║ Status Code: ${err.response?.statusCode}');
      print('║ URL: ${err.requestOptions.uri}');
      print('║ Error Type: ${err.type}');
      print('║ Error Message: ${err.message}');
      print('║ Response: ${err.response?.data}');
      print('╚════════════════════════════════════════════════════════════');
    }
    super.onError(err, handler);
  }
}

// ============================================================================
// 2. AUTH INTERCEPTOR - Add JWT token to requests
// ============================================================================
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;

  AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // Skip token for public endpoints
    if (_isPublicEndpoint(options.path)) {
      return super.onRequest(options, handler);
    }

    // Get token from secure storage
    final token = await _storage.read(key: 'auth_token');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  bool _isPublicEndpoint(String path) {
    final publicEndpoints = [
      '/auth/login',
      '/auth/register',
      '/auth/forgot-password',
      '/auth/refresh',
    ];
    return publicEndpoints.any((endpoint) => path.contains(endpoint));
  }
}

// ============================================================================
// 3. REFRESH TOKEN INTERCEPTOR - Handle token expiration
// ============================================================================
class RefreshTokenInterceptor extends QueuedInterceptor {
  final Dio _dio;
  final FlutterSecureStorage _storage;
  bool _isRefreshing = false;

  RefreshTokenInterceptor(this._dio, this._storage);

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    // Check if error is 401 (unauthorized)
    if (err.response?.statusCode == 401) {
      // Don't refresh on login/register endpoints
      if (_isAuthEndpoint(err.requestOptions.path)) {
        return handler.next(err);
      }

      // Prevent multiple simultaneous refresh attempts
      if (_isRefreshing) {
        return handler.next(err);
      }

      _isRefreshing = true;

      try {
        // Get refresh token
        final refreshToken = await _storage.read(key: 'refresh_token');

        if (refreshToken == null) {
          // No refresh token, user needs to login
          await _storage.deleteAll();
          return handler.reject(err);
        }

        // Call refresh endpoint
        final response = await _dio.post(
          '/auth/refresh',
          data: {'refresh_token': refreshToken},
          options: Options(
            headers: {'Authorization': 'Bearer $refreshToken'},
          ),
        );

        // Save new tokens
        final newAccessToken = response.data['access_token'];
        final newRefreshToken = response.data['refresh_token'];

        await _storage.write(key: 'auth_token', value: newAccessToken);
        await _storage.write(key: 'refresh_token', value: newRefreshToken);

        // Retry original request with new token
        final opts = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer $newAccessToken';

        final cloneReq = await _dio.fetch(opts);
        return handler.resolve(cloneReq);
      } catch (e) {
        // Refresh failed, clear tokens and logout
        await _storage.deleteAll();
        return handler.reject(err);
      } finally {
        _isRefreshing = false;
      }
    }

    super.onError(err, handler);
  }

  bool _isAuthEndpoint(String path) {
    return path.contains('/auth/login') ||
        path.contains('/auth/register') ||
        path.contains('/auth/refresh');
  }
}

// ============================================================================
// 4. ERROR INTERCEPTOR - Transform errors to custom exceptions
// ============================================================================
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: TimeoutException(err.requestOptions),
          ),
        );

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final message = err.response?.data['message'] ?? 'Unknown error';

        switch (statusCode) {
          case 400:
            return handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: BadRequestException(message),
              ),
            );
          case 401:
            return handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: UnauthorizedException(message),
              ),
            );
          case 403:
            return handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: ForbiddenException(message),
              ),
            );
          case 404:
            return handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: NotFoundException(message),
              ),
            );
          case 409:
            return handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: ConflictException(message),
              ),
            );
          case 422:
            return handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: ValidationException(
                  message,
                  err.response?.data['errors'],
                ),
              ),
            );
          case 500:
          case 502:
          case 503:
            return handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: ServerException(message),
              ),
            );
          default:
            return handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: ApiException(message),
              ),
            );
        }

      case DioExceptionType.cancel:
        return handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: RequestCancelledException(err.requestOptions),
          ),
        );

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: NoInternetConnectionException(err.requestOptions),
          ),
        );

      default:
        return handler.reject(err);
    }
  }
}

// ============================================================================
// 5. RETRY INTERCEPTOR - Retry failed requests
// ============================================================================
class RetryInterceptor extends Interceptor {
  final int maxRetries;
  final Duration retryDelay;

  RetryInterceptor({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    // Only retry on network errors, not auth or validation errors
    if (!_shouldRetry(err)) {
      return handler.next(err);
    }

    final retryCount = err.requestOptions.extra['retry_count'] ?? 0;

    if (retryCount >= maxRetries) {
      return handler.next(err);
    }

    // Wait before retrying
    await Future.delayed(retryDelay * (retryCount + 1));

    // Increment retry count
    err.requestOptions.extra['retry_count'] = retryCount + 1;

    // Retry request
    try {
      final response = await Dio().fetch(err.requestOptions);
      return handler.resolve(response);
    } catch (e) {
      return handler.next(err);
    }
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.response?.statusCode ?? 0) >= 500;
  }
}

// ============================================================================
// 6. CACHE INTERCEPTOR - Cache GET requests
// ============================================================================
class CacheInterceptor extends Interceptor {
  final Map<String, Response> _cache = {};
  final Duration cacheDuration;

  CacheInterceptor({this.cacheDuration = const Duration(minutes: 5)});

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // Only cache GET requests
    if (options.method != 'GET') {
      return super.onRequest(options, handler);
    }

    // Check if response is cached
    final cacheKey = _getCacheKey(options);
    final cachedResponse = _cache[cacheKey];

    if (cachedResponse != null) {
      // Check if cache is still valid
      final cacheTime = cachedResponse.extra['cache_time'] as DateTime;
      if (DateTime.now().difference(cacheTime) < cacheDuration) {
        // Return cached response
        return handler.resolve(cachedResponse);
      } else {
        // Cache expired, remove it
        _cache.remove(cacheKey);
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Cache successful GET responses
    if (response.requestOptions.method == 'GET' &&
        response.statusCode == 200) {
      final cacheKey = _getCacheKey(response.requestOptions);
      response.extra['cache_time'] = DateTime.now();
      _cache[cacheKey] = response;
    }

    super.onResponse(response, handler);
  }

  String _getCacheKey(RequestOptions options) {
    return '${options.uri}';
  }

  void clearCache() {
    _cache.clear();
  }
}

// ============================================================================
// 7. RATE LIMIT INTERCEPTOR - Prevent too many requests
// ============================================================================
class RateLimitInterceptor extends Interceptor {
  final int maxRequestsPerMinute;
  final List<DateTime> _requestTimes = [];

  RateLimitInterceptor({this.maxRequestsPerMinute = 60});

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // Remove old request times (older than 1 minute)
    final now = DateTime.now();
    _requestTimes.removeWhere(
          (time) => now.difference(time) > const Duration(minutes: 1),
    );

    // Check if rate limit exceeded
    if (_requestTimes.length >= maxRequestsPerMinute) {
      final oldestRequest = _requestTimes.first;
      final waitTime = const Duration(minutes: 1) - now.difference(oldestRequest);

      // Wait until rate limit resets
      await Future.delayed(waitTime);
    }

    // Add current request time
    _requestTimes.add(now);

    super.onRequest(options, handler);
  }
}

// ============================================================================
// CUSTOM EXCEPTIONS
// ============================================================================
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class BadRequestException extends ApiException {
  BadRequestException(String message) : super(message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message);
}

class ForbiddenException extends ApiException {
  ForbiddenException(String message) : super(message);
}

class NotFoundException extends ApiException {
  NotFoundException(String message) : super(message);
}

class ConflictException extends ApiException {
  ConflictException(String message) : super(message);
}

class ValidationException extends ApiException {
  final Map<String, dynamic>? errors;
  ValidationException(String message, this.errors) : super(message);
}

class ServerException extends ApiException {
  ServerException(String message) : super(message);
}

class TimeoutException extends ApiException {
  final RequestOptions requestOptions;
  TimeoutException(this.requestOptions) : super('Request timeout');
}

class RequestCancelledException extends ApiException {
  final RequestOptions requestOptions;
  RequestCancelledException(this.requestOptions) : super('Request cancelled');
}

class NoInternetConnectionException extends ApiException {
  final RequestOptions requestOptions;
  NoInternetConnectionException(this.requestOptions)
      : super('No internet connection');
}
