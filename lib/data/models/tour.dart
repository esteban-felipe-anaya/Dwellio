import 'package:freezed_annotation/freezed_annotation.dart';

part 'tour.freezed.dart';
part 'tour.g.dart';

/// A scheduled property viewing.
@freezed
abstract class Tour with _$Tour {
  const factory Tour({
    required String id,
    required String listingId,
    required String date,
    required String slot,
    @Default('pending') String status,
  }) = _Tour;

  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);
}
