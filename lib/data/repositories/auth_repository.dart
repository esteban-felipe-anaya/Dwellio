import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/guard.dart';
import '../../core/providers/core_providers.dart';
import '../api/dwellio_api.dart';
import '../models/user.dart';

/// Authentication API access. Token persistence is orchestrated by the auth
/// controller, not here.
class AuthRepository {
  AuthRepository(this._api);

  final DwellioApi _api;

  Future<AuthResponse> login(String email, String password) =>
      guard(() => _api.login({'email': email, 'password': password}));

  Future<AuthResponse> register(String name, String email, String password) =>
      guard(() => _api.register({
            'name': name,
            'email': email,
            'password': password,
          }));

  Future<User> me() async {
    final res = await guard(() => _api.me());
    return res.user;
  }
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.watch(dwellioApiProvider)),
);
