import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Runtime configuration for Dwellio.
///
/// Resolution order for each value (first match wins):
///   1. `--dart-define` (compile-time override, e.g. in CI)
///   2. the `.env` file loaded by flutter_dotenv at startup (edit, no recompile)
///   3. a sensible built-in default
///
///   flutter run --dart-define=DWELLIO_API_BASE_URL=http://10.0.2.2:8000
class Env {
  const Env._();

  /// Name of the env asset loaded in [main]. Declared under `assets:` in pubspec.
  static const String fileName = '.env';

  static const String _defaultBaseUrl = 'http://localhost:8000';

  static String? _fromDotenv(String key) {
    if (!dotenv.isInitialized) return null;
    final value = dotenv.maybeGet(key);
    return (value == null || value.isEmpty) ? null : value;
  }

  /// Base URL of the Dwellio backend (FastAPI). No trailing slash.
  ///
  /// Note: Android emulators reach the host machine via `10.0.2.2`, not
  /// `localhost`; physical devices use the host's LAN IP. See `.env`.
  static String get apiBaseUrl {
    const fromDefine = String.fromEnvironment('DWELLIO_API_BASE_URL');
    if (fromDefine.isNotEmpty) return fromDefine;
    return _fromDotenv('DWELLIO_API_BASE_URL') ?? _defaultBaseUrl;
  }

  /// When true, the network layer injects artificial latency and random
  /// failures so loading/error states are exercised in development.
  static bool get simulateNetwork {
    final fromEnv = _fromDotenv('DWELLIO_SIMULATE_NETWORK');
    if (fromEnv != null) return fromEnv.toLowerCase() == 'true';
    return const bool.fromEnvironment(
      'DWELLIO_SIMULATE_NETWORK',
      defaultValue: true,
    );
  }

  /// Default page size for paginated listing queries.
  static const int pageSize = 20;
}
