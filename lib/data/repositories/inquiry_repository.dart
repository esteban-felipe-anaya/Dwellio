import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/guard.dart';
import '../../core/providers/core_providers.dart';
import '../api/dwellio_api.dart';
import '../models/inquiry.dart';
import '../models/tour.dart';

/// Tours and agent message threads (My Inquiries).
class InquiryRepository {
  InquiryRepository(this._api);

  final DwellioApi _api;

  Future<List<Inquiry>> all() => guard(() => _api.inquiries());

  Future<Tour> scheduleTour({
    required String listingId,
    required String date,
    required String slot,
  }) =>
      guard(() => _api.scheduleTour({
            'listingId': listingId,
            'date': date,
            'slot': slot,
          }));

  Future<Inquiry> contactAgent({
    required String listingId,
    required String message,
  }) =>
      guard(() => _api.createInquiry({
            'listingId': listingId,
            'message': message,
          }));
}

final inquiryRepositoryProvider = Provider<InquiryRepository>(
  (ref) => InquiryRepository(ref.watch(dwellioApiProvider)),
);
