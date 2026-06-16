import 'package:dio/dio.dart';

/// A single, typed error surfaced to the UI layer. Repositories translate raw
/// [DioException]s into this so widgets never inspect Dio internals.
class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode, this.isNetwork = false});

  final String message;
  final int? statusCode;
  final bool isNetwork;

  bool get isUnauthorized => statusCode == 401;

  factory ApiException.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException(
          'The connection timed out. Please try again.',
          isNetwork: true,
        );
      case DioExceptionType.connectionError:
        return const ApiException(
          "Couldn't reach the server. Is the mock API running?",
          isNetwork: true,
        );
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        final data = e.response?.data;
        final serverMsg = (data is Map && data['message'] is String)
            ? data['message'] as String
            : null;
        return ApiException(
          serverMsg ?? _messageForStatus(code),
          statusCode: code,
        );
      case DioExceptionType.cancel:
        return const ApiException('Request cancelled.');
      default:
        return ApiException(
          e.message ?? 'Something went wrong. Please try again.',
          isNetwork: true,
        );
    }
  }

  static String _messageForStatus(int? code) {
    switch (code) {
      case 400:
        return 'That request was invalid.';
      case 401:
        return 'Please sign in to continue.';
      case 403:
        return "You don't have access to that.";
      case 404:
        return "We couldn't find what you were looking for.";
      case 409:
        return 'That already exists.';
      case 500:
      case 502:
      case 503:
        return 'The server had a problem. Please try again shortly.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  String toString() => message;
}
