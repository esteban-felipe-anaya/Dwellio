// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The set of favorited listing ids for the current user. Reloads whenever the
/// auth state changes so favorites follow the signed-in account.

@ProviderFor(FavoritesController)
final favoritesControllerProvider = FavoritesControllerProvider._();

/// The set of favorited listing ids for the current user. Reloads whenever the
/// auth state changes so favorites follow the signed-in account.
final class FavoritesControllerProvider
    extends $AsyncNotifierProvider<FavoritesController, Set<String>> {
  /// The set of favorited listing ids for the current user. Reloads whenever the
  /// auth state changes so favorites follow the signed-in account.
  FavoritesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesControllerHash();

  @$internal
  @override
  FavoritesController create() => FavoritesController();
}

String _$favoritesControllerHash() =>
    r'029f0d8bbe27d7819a0cd9ac9b2ed06ee714c804';

/// The set of favorited listing ids for the current user. Reloads whenever the
/// auth state changes so favorites follow the signed-in account.

abstract class _$FavoritesController extends $AsyncNotifier<Set<String>> {
  FutureOr<Set<String>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Set<String>>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Set<String>>, Set<String>>,
              AsyncValue<Set<String>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
