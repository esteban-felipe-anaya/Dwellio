import 'package:dio/dio.dart';

import 'api_exception.dart';

/// Runs an API call, converting any [DioException] into a typed [ApiException]
/// so repositories present a uniform error surface to the rest of the app.
Future<T> guard<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (e) {
    throw ApiException.fromDio(e);
  }
}
