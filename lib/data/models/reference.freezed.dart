// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PropertyType {

 String get id; String get name; String get icon;
/// Create a copy of PropertyType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PropertyTypeCopyWith<PropertyType> get copyWith => _$PropertyTypeCopyWithImpl<PropertyType>(this as PropertyType, _$identity);

  /// Serializes this PropertyType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PropertyType&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon);

@override
String toString() {
  return 'PropertyType(id: $id, name: $name, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $PropertyTypeCopyWith<$Res>  {
  factory $PropertyTypeCopyWith(PropertyType value, $Res Function(PropertyType) _then) = _$PropertyTypeCopyWithImpl;
@useResult
$Res call({
 String id, String name, String icon
});




}
/// @nodoc
class _$PropertyTypeCopyWithImpl<$Res>
    implements $PropertyTypeCopyWith<$Res> {
  _$PropertyTypeCopyWithImpl(this._self, this._then);

  final PropertyType _self;
  final $Res Function(PropertyType) _then;

/// Create a copy of PropertyType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? icon = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PropertyType].
extension PropertyTypePatterns on PropertyType {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PropertyType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PropertyType() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PropertyType value)  $default,){
final _that = this;
switch (_that) {
case _PropertyType():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PropertyType value)?  $default,){
final _that = this;
switch (_that) {
case _PropertyType() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PropertyType() when $default != null:
return $default(_that.id,_that.name,_that.icon);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String icon)  $default,) {final _that = this;
switch (_that) {
case _PropertyType():
return $default(_that.id,_that.name,_that.icon);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String icon)?  $default,) {final _that = this;
switch (_that) {
case _PropertyType() when $default != null:
return $default(_that.id,_that.name,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PropertyType implements PropertyType {
  const _PropertyType({required this.id, required this.name, this.icon = 'home'});
  factory _PropertyType.fromJson(Map<String, dynamic> json) => _$PropertyTypeFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  String icon;

/// Create a copy of PropertyType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PropertyTypeCopyWith<_PropertyType> get copyWith => __$PropertyTypeCopyWithImpl<_PropertyType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PropertyTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PropertyType&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon);

@override
String toString() {
  return 'PropertyType(id: $id, name: $name, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$PropertyTypeCopyWith<$Res> implements $PropertyTypeCopyWith<$Res> {
  factory _$PropertyTypeCopyWith(_PropertyType value, $Res Function(_PropertyType) _then) = __$PropertyTypeCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String icon
});




}
/// @nodoc
class __$PropertyTypeCopyWithImpl<$Res>
    implements _$PropertyTypeCopyWith<$Res> {
  __$PropertyTypeCopyWithImpl(this._self, this._then);

  final _PropertyType _self;
  final $Res Function(_PropertyType) _then;

/// Create a copy of PropertyType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? icon = null,}) {
  return _then(_PropertyType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Amenity {

 String get id; String get name; String get icon;
/// Create a copy of Amenity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AmenityCopyWith<Amenity> get copyWith => _$AmenityCopyWithImpl<Amenity>(this as Amenity, _$identity);

  /// Serializes this Amenity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Amenity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon);

@override
String toString() {
  return 'Amenity(id: $id, name: $name, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $AmenityCopyWith<$Res>  {
  factory $AmenityCopyWith(Amenity value, $Res Function(Amenity) _then) = _$AmenityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String icon
});




}
/// @nodoc
class _$AmenityCopyWithImpl<$Res>
    implements $AmenityCopyWith<$Res> {
  _$AmenityCopyWithImpl(this._self, this._then);

  final Amenity _self;
  final $Res Function(Amenity) _then;

/// Create a copy of Amenity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? icon = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Amenity].
extension AmenityPatterns on Amenity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Amenity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Amenity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Amenity value)  $default,){
final _that = this;
switch (_that) {
case _Amenity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Amenity value)?  $default,){
final _that = this;
switch (_that) {
case _Amenity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Amenity() when $default != null:
return $default(_that.id,_that.name,_that.icon);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String icon)  $default,) {final _that = this;
switch (_that) {
case _Amenity():
return $default(_that.id,_that.name,_that.icon);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String icon)?  $default,) {final _that = this;
switch (_that) {
case _Amenity() when $default != null:
return $default(_that.id,_that.name,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Amenity implements Amenity {
  const _Amenity({required this.id, required this.name, this.icon = 'check'});
  factory _Amenity.fromJson(Map<String, dynamic> json) => _$AmenityFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  String icon;

/// Create a copy of Amenity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AmenityCopyWith<_Amenity> get copyWith => __$AmenityCopyWithImpl<_Amenity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AmenityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Amenity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon);

@override
String toString() {
  return 'Amenity(id: $id, name: $name, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$AmenityCopyWith<$Res> implements $AmenityCopyWith<$Res> {
  factory _$AmenityCopyWith(_Amenity value, $Res Function(_Amenity) _then) = __$AmenityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String icon
});




}
/// @nodoc
class __$AmenityCopyWithImpl<$Res>
    implements _$AmenityCopyWith<$Res> {
  __$AmenityCopyWithImpl(this._self, this._then);

  final _Amenity _self;
  final $Res Function(_Amenity) _then;

/// Create a copy of Amenity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? icon = null,}) {
  return _then(_Amenity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
