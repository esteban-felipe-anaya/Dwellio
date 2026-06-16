import 'package:freezed_annotation/freezed_annotation.dart';

import 'search_filters.dart';

part 'saved_search.freezed.dart';
part 'saved_search.g.dart';

/// A named, re-runnable set of search criteria.
@freezed
abstract class SavedSearch with _$SavedSearch {
  const factory SavedSearch({
    required String id,
    required String label,
    required SearchFilters filters,
    String? createdAt,
  }) = _SavedSearch;

  factory SavedSearch.fromJson(Map<String, dynamic> json) =>
      _$SavedSearchFromJson(json);
}
