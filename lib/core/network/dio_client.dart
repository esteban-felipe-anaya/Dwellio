import 'package:dio/dio.dart';

import '../env/env.dart';
import 'interceptors.dart';
import 'token_holder.dart';

/// Builds the configured [Dio] instance used by the whole app.
Dio buildDio(TokenHolder tokens) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
      headers: {'Accept': 'application/json'},
    ),
  );

  dio.interceptors.add(AuthInterceptor(tokens));
  if (Env.simulateNetwork) {
    dio.interceptors.add(ChaosInterceptor());
  }
  dio.interceptors.add(LoggingInterceptor());

  return dio;
}
