import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/auth_repository.dart';

part 'auth_controller.g.dart';

/// Holds the current session. `null` data means "guest" (browsing is allowed);
/// a non-null [User] means the account is signed in.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<User?> build() async {
    final store = ref.watch(tokenStoreProvider);
    final holder = ref.watch(tokenHolderProvider);

    final token = await store.read();
    if (token == null || token.isEmpty) return null;

    holder.set(token);
    try {
      return await ref.read(authRepositoryProvider).me();
    } catch (_) {
      // Stale/invalid token — fall back to guest.
      holder.clear();
      await store.clear();
      return null;
    }
  }

  bool get isAuthenticated => state.value != null;

  Future<void> login(String email, String password) async {
    final res = await ref.read(authRepositoryProvider).login(email, password);
    await _persist(res.token);
    state = AsyncData(res.user);
  }

  Future<void> register(String name, String email, String password) async {
    final res =
        await ref.read(authRepositoryProvider).register(name, email, password);
    await _persist(res.token);
    state = AsyncData(res.user);
  }

  Future<void> logout() async {
    ref.read(tokenHolderProvider).clear();
    await ref.read(tokenStoreProvider).clear();
    state = const AsyncData(null);
  }

  Future<void> _persist(String token) async {
    ref.read(tokenHolderProvider).set(token);
    await ref.read(tokenStoreProvider).write(token);
  }
}

/// Convenience boolean for widgets that only care whether someone is signed in.
@riverpod
bool isAuthenticated(Ref ref) {
  final auth = ref.watch(authControllerProvider);
  return auth.value != null;
}
