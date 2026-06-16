import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/favorites_repository.dart';
import '../../auth/application/auth_controller.dart';

part 'favorites_controller.g.dart';

/// The set of favorited listing ids for the current user. Reloads whenever the
/// auth state changes so favorites follow the signed-in account.
@Riverpod(keepAlive: true)
class FavoritesController extends _$FavoritesController {
  @override
  Future<Set<String>> build() async {
    final authed = ref.watch(isAuthenticatedProvider);
    if (!authed) return <String>{};
    final ids = await ref.read(favoritesRepositoryProvider).all();
    return ids.toSet();
  }

  bool isFavorite(String id) => state.value?.contains(id) ?? false;

  /// Optimistically toggles, then syncs with the server (rolling back on
  /// failure). Callers must ensure the user is authenticated first.
  Future<void> toggle(String id) async {
    final repo = ref.read(favoritesRepositoryProvider);
    final previous = state.value ?? <String>{};
    final next = {...previous};
    final adding = !next.contains(id);
    adding ? next.add(id) : next.remove(id);
    state = AsyncData(next);

    try {
      adding ? await repo.add(id) : await repo.remove(id);
    } catch (e) {
      state = AsyncData(previous); // roll back
      rethrow;
    }
  }
}
