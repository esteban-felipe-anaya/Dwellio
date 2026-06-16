// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tour.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Tour {

 String get id; String get listingId; String get date; String get slot; String get status;
/// Create a copy of Tour
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TourCopyWith<Tour> get copyWith => _$TourCopyWithImpl<Tour>(this as Tour, _$identity);

  /// Serializes this Tour to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tour&&(identical(other.id, id) || other.id == id)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.date, date) || other.date == date)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,listingId,date,slot,status);

@override
String toString() {
  return 'Tour(id: $id, listingId: $listingId, date: $date, slot: $slot, status: $status)';
}


}

/// @nodoc
abstract mixin class $TourCopyWith<$Res>  {
  factory $TourCopyWith(Tour value, $Res Function(Tour) _then) = _$TourCopyWithImpl;
@useResult
$Res call({
 String id, String listingId, String date, String slot, String status
});




}
/// @nodoc
class _$TourCopyWithImpl<$Res>
    implements $TourCopyWith<$Res> {
  _$TourCopyWithImpl(this._self, this._then);

  final Tour _self;
  final $Res Function(Tour) _then;

/// Create a copy of Tour
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? listingId = null,Object? date = null,Object? slot = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Tour].
extension TourPatterns on Tour {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tour value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tour() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tour value)  $default,){
final _that = this;
switch (_that) {
case _Tour():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tour value)?  $default,){
final _that = this;
switch (_that) {
case _Tour() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String listingId,  String date,  String slot,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tour() when $default != null:
return $default(_that.id,_that.listingId,_that.date,_that.slot,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String listingId,  String date,  String slot,  String status)  $default,) {final _that = this;
switch (_that) {
case _Tour():
return $default(_that.id,_that.listingId,_that.date,_that.slot,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String listingId,  String date,  String slot,  String status)?  $default,) {final _that = this;
switch (_that) {
case _Tour() when $default != null:
return $default(_that.id,_that.listingId,_that.date,_that.slot,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Tour implements Tour {
  const _Tour({required this.id, required this.listingId, required this.date, required this.slot, this.status = 'pending'});
  factory _Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);

@override final  String id;
@override final  String listingId;
@override final  String date;
@override final  String slot;
@override@JsonKey() final  String status;

/// Create a copy of Tour
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TourCopyWith<_Tour> get copyWith => __$TourCopyWithImpl<_Tour>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TourToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tour&&(identical(other.id, id) || other.id == id)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.date, date) || other.date == date)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,listingId,date,slot,status);

@override
String toString() {
  return 'Tour(id: $id, listingId: $listingId, date: $date, slot: $slot, status: $status)';
}


}

/// @nodoc
abstract mixin class _$TourCopyWith<$Res> implements $TourCopyWith<$Res> {
  factory _$TourCopyWith(_Tour value, $Res Function(_Tour) _then) = __$TourCopyWithImpl;
@override @useResult
$Res call({
 String id, String listingId, String date, String slot, String status
});




}
/// @nodoc
class __$TourCopyWithImpl<$Res>
    implements _$TourCopyWith<$Res> {
  __$TourCopyWithImpl(this._self, this._then);

  final _Tour _self;
  final $Res Function(_Tour) _then;

/// Create a copy of Tour
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? listingId = null,Object? date = null,Object? slot = null,Object? status = null,}) {
  return _then(_Tour(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
