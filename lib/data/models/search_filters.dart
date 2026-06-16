import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_filters.freezed.dart';
part 'search_filters.g.dart';

/// Sort options exposed in the search UI. The wire value matches the mock API.
enum SortOption {
  newest('newest', 'Newest'),
  priceAsc('price_asc', 'Price: Low to High'),
  priceDesc('price_desc', 'Price: High to Low'),
  areaDesc('area_desc', 'Largest area');

  const SortOption(this.value, this.label);
  final String value;
  final String label;

  static SortOption fromValue(String? v) =>
      SortOption.values.firstWhere((e) => e.value == v, orElse: () => newest);
}

/// The complete set of search criteria. Doubles as the persisted payload for
/// saved searches (via [toJson]) and the source for API query params (via
/// [toQuery]).
@freezed
abstract class SearchFilters with _$SearchFilters {
  const factory SearchFilters({
    @Default('buy') String dealType, // 'buy' | 'rent'
    String? q,
    num? minPrice,
    num? maxPrice,
    int? beds,
    int? baths,
    String? type,
    num? minArea,
    @Default(<String>[]) List<String> amenities,
    @Default('newest') String sort,
    // Map bounds (set only while searching by map viewport).
    double? swLat,
    double? swLng,
    double? neLat,
    double? neLng,
  }) = _SearchFilters;

  const SearchFilters._();

  factory SearchFilters.fromJson(Map<String, dynamic> json) =>
      _$SearchFiltersFromJson(json);

  bool get hasBounds =>
      swLat != null && swLng != null && neLat != null && neLng != null;

  /// Returns a copy with map bounds removed (freezed's copyWith can't unset
  /// a nullable field).
  SearchFilters clearBounds() => SearchFilters(
        dealType: dealType,
        q: q,
        minPrice: minPrice,
        maxPrice: maxPrice,
        beds: beds,
        baths: baths,
        type: type,
        minArea: minArea,
        amenities: amenities,
        sort: sort,
      );

  /// Resets every content filter while preserving deal type and sort.
  SearchFilters cleared() =>
      SearchFilters(dealType: dealType, sort: sort);

  /// Number of *content* filters active (ignores deal type, sort and bounds).
  /// Drives the filter button's badge count.
  int get activeCount {
    var n = 0;
    if (q != null && q!.isNotEmpty) n++;
    if (minPrice != null) n++;
    if (maxPrice != null) n++;
    if (beds != null) n++;
    if (baths != null) n++;
    if (type != null) n++;
    if (minArea != null) n++;
    if (amenities.isNotEmpty) n++;
    return n;
  }

  /// Builds the query-parameter map for the listings endpoint, omitting any
  /// unset value so the API only filters on what the user actually chose.
  Map<String, dynamic> toQuery() {
    final map = <String, dynamic>{
      'dealType': dealType,
      'sort': sort,
    };
    if (q != null && q!.isNotEmpty) map['q'] = q;
    if (minPrice != null) map['minPrice'] = minPrice;
    if (maxPrice != null) map['maxPrice'] = maxPrice;
    if (beds != null) map['beds'] = beds;
    if (baths != null) map['baths'] = baths;
    if (type != null) map['type'] = type;
    if (minArea != null) map['minArea'] = minArea;
    if (amenities.isNotEmpty) map['amenities'] = amenities.join(',');
    if (hasBounds) {
      map['swLat'] = swLat;
      map['swLng'] = swLng;
      map['neLat'] = neLat;
      map['neLng'] = neLng;
    }
    return map;
  }
}
