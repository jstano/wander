import 'package:dio/dio.dart';
import 'package:wander/core/adapters/network/api_interceptors.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.example.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    dio.interceptors.addAll([
      LoggingInterceptor(),
      // AuthInterceptor(),
      ErrorInterceptor(),
    ]);
  }

  static Dio get instance => _instance.dio;
}
