// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchFilters _$SearchFiltersFromJson(Map<String, dynamic> json) =>
    _SearchFilters(
      dealType: json['dealType'] as String? ?? 'buy',
      q: json['q'] as String?,
      minPrice: json['minPrice'] as num?,
      maxPrice: json['maxPrice'] as num?,
      beds: (json['beds'] as num?)?.toInt(),
      baths: (json['baths'] as num?)?.toInt(),
      type: json['type'] as String?,
      minArea: json['minArea'] as num?,
      amenities:
          (json['amenities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      sort: json['sort'] as String? ?? 'newest',
      swLat: (json['swLat'] as num?)?.toDouble(),
      swLng: (json['swLng'] as num?)?.toDouble(),
      neLat: (json['neLat'] as num?)?.toDouble(),
      neLng: (json['neLng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SearchFiltersToJson(_SearchFilters instance) =>
    <String, dynamic>{
      'dealType': instance.dealType,
      'q': instance.q,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'beds': instance.beds,
      'baths': instance.baths,
      'type': instance.type,
      'minArea': instance.minArea,
      'amenities': instance.amenities,
      'sort': instance.sort,
      'swLat': instance.swLat,
      'swLng': instance.swLng,
      'neLat': instance.neLat,
      'neLng': instance.neLng,
    };
