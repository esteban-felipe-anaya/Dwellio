// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_searches_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Persisted saved searches that can be re-run from the saved-searches screen.

@ProviderFor(SavedSearchesController)
final savedSearchesControllerProvider = SavedSearchesControllerProvider._();

/// Persisted saved searches that can be re-run from the saved-searches screen.
final class SavedSearchesControllerProvider
    extends $AsyncNotifierProvider<SavedSearchesController, List<SavedSearch>> {
  /// Persisted saved searches that can be re-run from the saved-searches screen.
  SavedSearchesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedSearchesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedSearchesControllerHash();

  @$internal
  @override
  SavedSearchesController create() => SavedSearchesController();
}

String _$savedSearchesControllerHash() =>
    r'c1a7c6433b00ad547cd9ebb9d3eea1447a2053f0';

/// Persisted saved searches that can be re-run from the saved-searches screen.

abstract class _$SavedSearchesController
    extends $AsyncNotifier<List<SavedSearch>> {
  FutureOr<List<SavedSearch>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<SavedSearch>>, List<SavedSearch>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SavedSearch>>, List<SavedSearch>>,
              AsyncValue<List<SavedSearch>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
