// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Owns search criteria, the result set, and the map↔list selection link.
/// A single source of truth shared by the results list and the map. Kept alive
/// so search state survives navigating away and back.

@ProviderFor(SearchController)
final searchControllerProvider = SearchControllerProvider._();

/// Owns search criteria, the result set, and the map↔list selection link.
/// A single source of truth shared by the results list and the map. Kept alive
/// so search state survives navigating away and back.
final class SearchControllerProvider
    extends $NotifierProvider<SearchController, SearchState> {
  /// Owns search criteria, the result set, and the map↔list selection link.
  /// A single source of truth shared by the results list and the map. Kept alive
  /// so search state survives navigating away and back.
  SearchControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchControllerHash();

  @$internal
  @override
  SearchController create() => SearchController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchState>(value),
    );
  }
}

String _$searchControllerHash() => r'd9f5f3012a64bc3eb432c03987e2ce4615f679e0';

/// Owns search criteria, the result set, and the map↔list selection link.
/// A single source of truth shared by the results list and the map. Kept alive
/// so search state survives navigating away and back.

abstract class _$SearchController extends $Notifier<SearchState> {
  SearchState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SearchState, SearchState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SearchState, SearchState>,
              SearchState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
