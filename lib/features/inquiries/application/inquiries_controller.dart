import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/inquiry.dart';
import '../../../data/repositories/inquiry_repository.dart';

part 'inquiries_controller.g.dart';

/// Tours + agent message threads shown on the Inquiries screen. Scheduling a
/// tour or messaging an agent refreshes the list so it appears immediately.
@riverpod
class InquiriesController extends _$InquiriesController {
  @override
  Future<List<Inquiry>> build() => ref.read(inquiryRepositoryProvider).all();

  Future<void> scheduleTour({
    required String listingId,
    required String date,
    required String slot,
  }) async {
    await ref.read(inquiryRepositoryProvider).scheduleTour(
          listingId: listingId,
          date: date,
          slot: slot,
        );
    ref.invalidateSelf();
    await future;
  }

  Future<void> contactAgent({
    required String listingId,
    required String message,
  }) async {
    await ref
        .read(inquiryRepositoryProvider)
        .contactAgent(listingId: listingId, message: message);
    ref.invalidateSelf();
    await future;
  }
}
