import 'package:freezed_annotation/freezed_annotation.dart';

part 'listing.freezed.dart';
part 'listing.g.dart';

/// A property listing. The single source of truth for everything shown on
/// cards, the search map, and the detail screen.
@freezed
abstract class Listing with _$Listing {
  const factory Listing({
    required String id,
    required String title,
    required String dealType, // 'buy' | 'rent'
    required num price,
    @Default('USD') String currency,
    required String propertyType,
    @Default(0) int beds,
    @Default(0) int baths,
    @Default(0) num areaSqm,
    @Default(0) int parking,
    @Default('') String address,
    @Default('') String city,
    required double lat,
    required double lng,
    @Default(<String>[]) List<String> amenities,
    @Default(<String>[]) List<String> photos,
    @Default('') String agentId,
    @Default('') String description,
    @Default(false) bool featured,
    String? listedAt,
  }) = _Listing;

  const Listing._();

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);

  bool get isRental => dealType == 'rent';

  /// First photo, or empty string when a listing has none.
  String get coverPhoto => photos.isNotEmpty ? photos.first : '';
}
