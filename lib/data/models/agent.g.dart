// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Agent _$AgentFromJson(Map<String, dynamic> json) => _Agent(
  id: json['id'] as String,
  name: json['name'] as String,
  photo: json['photo'] as String?,
  agency: json['agency'] as String? ?? '',
  phone: json['phone'] as String? ?? '',
  rating: json['rating'] as num? ?? 0,
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AgentToJson(_Agent instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'photo': instance.photo,
  'agency': instance.agency,
  'phone': instance.phone,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
};
