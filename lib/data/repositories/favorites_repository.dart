import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/guard.dart';
import '../../core/providers/core_providers.dart';
import '../api/dwellio_api.dart';

/// Server-backed favorites (a flat list of listing ids).
class FavoritesRepository {
  FavoritesRepository(this._api);

  final DwellioApi _api;

  Future<List<String>> all() => guard(() => _api.favorites());

  Future<void> add(String listingId) =>
      guard(() => _api.addFavorite({'listingId': listingId}));

  Future<void> remove(String listingId) =>
      guard(() => _api.removeFavorite(listingId));
}

final favoritesRepositoryProvider = Provider<FavoritesRepository>(
  (ref) => FavoritesRepository(ref.watch(dwellioApiProvider)),
);
