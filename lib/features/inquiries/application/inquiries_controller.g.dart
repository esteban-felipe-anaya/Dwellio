// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inquiries_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Tours + agent message threads shown on the Inquiries screen. Scheduling a
/// tour or messaging an agent refreshes the list so it appears immediately.

@ProviderFor(InquiriesController)
final inquiriesControllerProvider = InquiriesControllerProvider._();

/// Tours + agent message threads shown on the Inquiries screen. Scheduling a
/// tour or messaging an agent refreshes the list so it appears immediately.
final class InquiriesControllerProvider
    extends $AsyncNotifierProvider<InquiriesController, List<Inquiry>> {
  /// Tours + agent message threads shown on the Inquiries screen. Scheduling a
  /// tour or messaging an agent refreshes the list so it appears immediately.
  InquiriesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inquiriesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inquiriesControllerHash();

  @$internal
  @override
  InquiriesController create() => InquiriesController();
}

String _$inquiriesControllerHash() =>
    r'55383cb7edd566af6c0ab5c4c30730ecb1970426';

/// Tours + agent message threads shown on the Inquiries screen. Scheduling a
/// tour or messaging an agent refreshes the list so it appears immediately.

abstract class _$InquiriesController extends $AsyncNotifier<List<Inquiry>> {
  FutureOr<List<Inquiry>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Inquiry>>, List<Inquiry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Inquiry>>, List<Inquiry>>,
              AsyncValue<List<Inquiry>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
