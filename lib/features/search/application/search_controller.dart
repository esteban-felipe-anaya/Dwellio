import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/listing.dart';
import '../../../data/models/search_filters.dart';
import '../../../data/repositories/listing_repository.dart';

part 'search_controller.g.dart';

/// View mode on compact screens (map and list are split on wide screens).
enum SearchView { list, map }

class SearchState {
  const SearchState({
    required this.filters,
    required this.results,
    this.selectedId,
    this.view = SearchView.list,
    this.searchAsMapMoves = true,
  });

  final SearchFilters filters;
  final AsyncValue<List<Listing>> results;

  /// Listing currently highlighted via map↔list linking.
  final String? selectedId;
  final SearchView view;
  final bool searchAsMapMoves;

  List<Listing> get listings => results.value ?? const [];

  SearchState copyWith({
    SearchFilters? filters,
    AsyncValue<List<Listing>>? results,
    String? selectedId,
    bool clearSelection = false,
    SearchView? view,
    bool? searchAsMapMoves,
  }) =>
      SearchState(
        filters: filters ?? this.filters,
        results: results ?? this.results,
        selectedId: clearSelection ? null : (selectedId ?? this.selectedId),
        view: view ?? this.view,
        searchAsMapMoves: searchAsMapMoves ?? this.searchAsMapMoves,
      );
}

/// Owns search criteria, the result set, and the map↔list selection link.
/// A single source of truth shared by the results list and the map. Kept alive
/// so search state survives navigating away and back.
@Riverpod(keepAlive: true)
class SearchController extends _$SearchController {
  Timer? _debounce;

  @override
  SearchState build() {
    ref.onDispose(() => _debounce?.cancel());
    // Kick off the initial query; UI shows a skeleton until it lands.
    Future.microtask(() => _load(const SearchFilters()));
    return const SearchState(
      filters: SearchFilters(),
      results: AsyncValue.loading(),
    );
  }

  Future<void> _load(SearchFilters filters) async {
    state = state.copyWith(results: const AsyncValue.loading());
    final res = await AsyncValue.guard(
      () => ref.read(listingRepositoryProvider).search(filters, limit: 60),
    );
    state = state.copyWith(results: res);
  }

  /// Replaces all filters (e.g. from the filter sheet) and re-queries.
  void applyFilters(SearchFilters filters) {
    state = state.copyWith(filters: filters, clearSelection: true);
    _load(filters);
  }

  void setDealType(String dealType) {
    final next = state.filters.copyWith(dealType: dealType);
    applyFilters(next);
  }

  void setSort(String sort) {
    final next = state.filters.copyWith(sort: sort);
    applyFilters(next);
  }

  void setQuery(String? query) {
    final next = state.filters.copyWith(q: (query?.isEmpty ?? true) ? null : query);
    applyFilters(next);
  }

  void setPropertyType(String? type) {
    // copyWith can't unset a nullable field, so rebuild when clearing.
    applyFilters(
      type == null ? _withoutType(state.filters) : state.filters.copyWith(type: type),
    );
  }

  SearchFilters _withoutType(SearchFilters f) => SearchFilters(
        dealType: f.dealType,
        q: f.q,
        minPrice: f.minPrice,
        maxPrice: f.maxPrice,
        beds: f.beds,
        baths: f.baths,
        minArea: f.minArea,
        amenities: f.amenities,
        sort: f.sort,
      );

  void clearAll() => applyFilters(state.filters.cleared());

  /// Map moved — re-query by viewport bounds (debounced) when enabled.
  void onMapBoundsChanged(
    double swLat,
    double swLng,
    double neLat,
    double neLng,
  ) {
    if (!state.searchAsMapMoves) return;
    final next = state.filters.copyWith(
      swLat: swLat,
      swLng: swLng,
      neLat: neLat,
      neLng: neLng,
    );
    state = state.copyWith(filters: next);
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () => _load(next));
  }

  void toggleSearchAsMapMoves(bool value) {
    state = state.copyWith(searchAsMapMoves: value);
    if (!value) {
      final cleared = state.filters.clearBounds();
      state = state.copyWith(filters: cleared);
      _load(cleared);
    }
  }

  /// Map↔list link: highlight a listing (tap a pin or a card).
  void select(String? id) {
    state = id == null
        ? state.copyWith(clearSelection: true)
        : state.copyWith(selectedId: id);
  }

  void setView(SearchView view) => state = state.copyWith(view: view);

  /// Re-run a saved search.
  void runFilters(SearchFilters filters) => applyFilters(filters);

  void refresh() => _load(state.filters);
}
