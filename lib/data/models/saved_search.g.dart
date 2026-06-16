// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SavedSearch _$SavedSearchFromJson(Map<String, dynamic> json) => _SavedSearch(
  id: json['id'] as String,
  label: json['label'] as String,
  filters: SearchFilters.fromJson(json['filters'] as Map<String, dynamic>),
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$SavedSearchToJson(_SavedSearch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'filters': instance.filters,
      'createdAt': instance.createdAt,
    };
