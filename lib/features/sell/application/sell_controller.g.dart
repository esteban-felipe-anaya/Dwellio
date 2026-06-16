// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sell_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Drives the create-listing wizard and publishes to the API.

@ProviderFor(SellController)
final sellControllerProvider = SellControllerProvider._();

/// Drives the create-listing wizard and publishes to the API.
final class SellControllerProvider
    extends $NotifierProvider<SellController, ListingDraft> {
  /// Drives the create-listing wizard and publishes to the API.
  SellControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sellControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sellControllerHash();

  @$internal
  @override
  SellController create() => SellController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListingDraft value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListingDraft>(value),
    );
  }
}

String _$sellControllerHash() => r'c2d37d5691200fb125dd84383d280a7f1cd0b5e6';

/// Drives the create-listing wizard and publishes to the API.

abstract class _$SellController extends $Notifier<ListingDraft> {
  ListingDraft build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ListingDraft, ListingDraft>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ListingDraft, ListingDraft>,
              ListingDraft,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Listings created by the current user during this session ("My listings").

@ProviderFor(MyListingsController)
final myListingsControllerProvider = MyListingsControllerProvider._();

/// Listings created by the current user during this session ("My listings").
final class MyListingsControllerProvider
    extends $NotifierProvider<MyListingsController, List<Listing>> {
  /// Listings created by the current user during this session ("My listings").
  MyListingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myListingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myListingsControllerHash();

  @$internal
  @override
  MyListingsController create() => MyListingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Listing> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Listing>>(value),
    );
  }
}

String _$myListingsControllerHash() =>
    r'2b8f2ecd8ce9dda83ef56bae9d9b34aa47f91da2';

/// Listings created by the current user during this session ("My listings").

abstract class _$MyListingsController extends $Notifier<List<Listing>> {
  List<Listing> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<Listing>, List<Listing>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Listing>, List<Listing>>,
              List<Listing>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
