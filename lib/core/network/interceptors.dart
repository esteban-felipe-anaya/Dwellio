import 'dart:developer' as developer;
import 'dart:math';

import 'package:dio/dio.dart';

import 'token_holder.dart';

/// Attaches the bearer token (when present) to every outgoing request.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokens);

  final TokenHolder _tokens;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokens.token;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

/// Lightweight logging that stays out of release builds' critical path.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    developer.log('→ ${options.method} ${options.uri}', name: 'dwellio.http');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    developer.log(
      '← ${response.statusCode} ${response.requestOptions.uri}',
      name: 'dwellio.http',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    developer.log(
      '✗ ${err.response?.statusCode ?? err.type} ${err.requestOptions.uri}',
      name: 'dwellio.http',
    );
    handler.next(err);
  }
}

/// Development-only interceptor that makes the network feel real: it adds
/// 300–800 ms of latency and occasionally injects a transient failure so the
/// app's loading and error states are continuously exercised.
class ChaosInterceptor extends Interceptor {
  ChaosInterceptor({
    this.minLatency = const Duration(milliseconds: 300),
    this.maxLatency = const Duration(milliseconds: 800),
    this.failureRate = 0.08,
  });

  final Duration minLatency;
  final Duration maxLatency;
  final double failureRate;
  final Random _random = Random();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final span = maxLatency.inMilliseconds - minLatency.inMilliseconds;
    final delay = minLatency.inMilliseconds + _random.nextInt(max(1, span));
    await Future<void>.delayed(Duration(milliseconds: delay));

    // Never sabotage auth so the demo login stays reliable.
    final isAuth = options.path.contains('/auth/');
    if (!isAuth && _random.nextDouble() < failureRate) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'Simulated network failure',
        ),
      );
      return;
    }
    handler.next(options);
  }
}
