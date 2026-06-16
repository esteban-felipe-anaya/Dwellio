import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/guard.dart';
import '../../core/providers/core_providers.dart';
import '../api/dwellio_api.dart';
import '../models/saved_search.dart';
import '../models/search_filters.dart';

/// Persisted, re-runnable saved searches.
class SavedSearchRepository {
  SavedSearchRepository(this._api);

  final DwellioApi _api;

  Future<List<SavedSearch>> all() => guard(() => _api.savedSearches());

  Future<SavedSearch> create(String label, SearchFilters filters) =>
      guard(() => _api.createSavedSearch({
            'label': label,
            'filters': filters.toJson(),
            'createdAt': DateTime.now().toUtc().toIso8601String(),
          }));
}

final savedSearchRepositoryProvider = Provider<SavedSearchRepository>(
  (ref) => SavedSearchRepository(ref.watch(dwellioApiProvider)),
);
