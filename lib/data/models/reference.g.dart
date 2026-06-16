// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PropertyType _$PropertyTypeFromJson(Map<String, dynamic> json) =>
    _PropertyType(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String? ?? 'home',
    );

Map<String, dynamic> _$PropertyTypeToJson(_PropertyType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
    };

_Amenity _$AmenityFromJson(Map<String, dynamic> json) => _Amenity(
  id: json['id'] as String,
  name: json['name'] as String,
  icon: json['icon'] as String? ?? 'check',
);

Map<String, dynamic> _$AmenityToJson(_Amenity instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'icon': instance.icon,
};
