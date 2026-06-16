import 'package:freezed_annotation/freezed_annotation.dart';

part 'reference.freezed.dart';
part 'reference.g.dart';

/// A selectable property type (apartment, house, …) used in filters and the
/// home shortcuts row.
@freezed
abstract class PropertyType with _$PropertyType {
  const factory PropertyType({
    required String id,
    required String name,
    @Default('home') String icon,
  }) = _PropertyType;

  factory PropertyType.fromJson(Map<String, dynamic> json) =>
      _$PropertyTypeFromJson(json);
}

/// A selectable amenity (gym, pool, …).
@freezed
abstract class Amenity with _$Amenity {
  const factory Amenity({
    required String id,
    required String name,
    @Default('check') String icon,
  }) = _Amenity;

  factory Amenity.fromJson(Map<String, dynamic> json) =>
      _$AmenityFromJson(json);
}
