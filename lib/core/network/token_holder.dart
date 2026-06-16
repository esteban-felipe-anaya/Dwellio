/// In-memory holder for the auth token so synchronous request interceptors can
/// read it without awaiting secure storage on every call.
///
/// The auth controller is the single writer: it hydrates this at startup and
/// updates it on login/logout. Persistence lives in [TokenStore].
class TokenHolder {
  String? _token;

  String? get token => _token;
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;

  void set(String? value) => _token = value;
  void clear() => _token = null;
}
