/// Runtime configuration for Dwellio.
///
/// The API base URL can be overridden at build/run time without touching code:
///
///   flutter run --dart-define=DWELLIO_API_BASE_URL=http://10.0.2.2:3000
///
/// Defaults are chosen so the app "just works" against a local json-server.
class Env {
  const Env._();

  /// Base URL of the Dwellio backend (FastAPI). Port 8000.
  ///
  /// Note: Android emulators reach the host machine via `10.0.2.2`, not
  /// `localhost`; physical devices use the host's LAN IP. See the README.
  static const String apiBaseUrl = String.fromEnvironment(
    'DWELLIO_API_BASE_URL',
    defaultValue: 'http://192.168.6.124:8000',
  );

  /// When true, the network layer injects artificial latency and random
  /// failures so loading/error states are exercised in development.
  static const bool simulateNetwork = bool.fromEnvironment(
    'DWELLIO_SIMULATE_NETWORK',
    defaultValue: true,
  );

  /// Default page size for paginated listing queries.
  static const int pageSize = 20;
}
