import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/saved_search.dart';
import '../../../data/models/search_filters.dart';
import '../../../data/repositories/saved_search_repository.dart';

part 'saved_searches_controller.g.dart';

/// Persisted saved searches that can be re-run from the saved-searches screen.
@riverpod
class SavedSearchesController extends _$SavedSearchesController {
  @override
  Future<List<SavedSearch>> build() =>
      ref.read(savedSearchRepositoryProvider).all();

  Future<void> save(String label, SearchFilters filters) async {
    await ref.read(savedSearchRepositoryProvider).create(label, filters);
    ref.invalidateSelf();
    await future;
  }
}
