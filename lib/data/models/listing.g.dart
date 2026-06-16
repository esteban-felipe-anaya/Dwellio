// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Listing _$ListingFromJson(Map<String, dynamic> json) => _Listing(
  id: json['id'] as String,
  title: json['title'] as String,
  dealType: json['dealType'] as String,
  price: json['price'] as num,
  currency: json['currency'] as String? ?? 'USD',
  propertyType: json['propertyType'] as String,
  beds: (json['beds'] as num?)?.toInt() ?? 0,
  baths: (json['baths'] as num?)?.toInt() ?? 0,
  areaSqm: json['areaSqm'] as num? ?? 0,
  parking: (json['parking'] as num?)?.toInt() ?? 0,
  address: json['address'] as String? ?? '',
  city: json['city'] as String? ?? '',
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
  amenities:
      (json['amenities'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  photos:
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  agentId: json['agentId'] as String? ?? '',
  description: json['description'] as String? ?? '',
  featured: json['featured'] as bool? ?? false,
  listedAt: json['listedAt'] as String?,
);

Map<String, dynamic> _$ListingToJson(_Listing instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'dealType': instance.dealType,
  'price': instance.price,
  'currency': instance.currency,
  'propertyType': instance.propertyType,
  'beds': instance.beds,
  'baths': instance.baths,
  'areaSqm': instance.areaSqm,
  'parking': instance.parking,
  'address': instance.address,
  'city': instance.city,
  'lat': instance.lat,
  'lng': instance.lng,
  'amenities': instance.amenities,
  'photos': instance.photos,
  'agentId': instance.agentId,
  'description': instance.description,
  'featured': instance.featured,
  'listedAt': instance.listedAt,
};
