import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander/core/adapters/network/dio_client.dart';

// Core infrastructure providers
final dioProvider = Provider<Dio>((ref) {
  return DioClient.instance;
});
