// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Tour _$TourFromJson(Map<String, dynamic> json) => _Tour(
  id: json['id'] as String,
  listingId: json['listingId'] as String,
  date: json['date'] as String,
  slot: json['slot'] as String,
  status: json['status'] as String? ?? 'pending',
);

Map<String, dynamic> _$TourToJson(_Tour instance) => <String, dynamic>{
  'id': instance.id,
  'listingId': instance.listingId,
  'date': instance.date,
  'slot': instance.slot,
  'status': instance.status,
};
