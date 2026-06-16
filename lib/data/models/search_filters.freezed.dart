// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchFilters {

 String get dealType; String? get q; num? get minPrice; num? get maxPrice; int? get beds; int? get baths; String? get type; num? get minArea; List<String> get amenities; String get sort; double? get swLat; double? get swLng; double? get neLat; double? get neLng;
/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFiltersCopyWith<SearchFilters> get copyWith => _$SearchFiltersCopyWithImpl<SearchFilters>(this as SearchFilters, _$identity);

  /// Serializes this SearchFilters to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFilters&&(identical(other.dealType, dealType) || other.dealType == dealType)&&(identical(other.q, q) || other.q == q)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.beds, beds) || other.beds == beds)&&(identical(other.baths, baths) || other.baths == baths)&&(identical(other.type, type) || other.type == type)&&(identical(other.minArea, minArea) || other.minArea == minArea)&&const DeepCollectionEquality().equals(other.amenities, amenities)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.swLat, swLat) || other.swLat == swLat)&&(identical(other.swLng, swLng) || other.swLng == swLng)&&(identical(other.neLat, neLat) || other.neLat == neLat)&&(identical(other.neLng, neLng) || other.neLng == neLng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dealType,q,minPrice,maxPrice,beds,baths,type,minArea,const DeepCollectionEquality().hash(amenities),sort,swLat,swLng,neLat,neLng);

@override
String toString() {
  return 'SearchFilters(dealType: $dealType, q: $q, minPrice: $minPrice, maxPrice: $maxPrice, beds: $beds, baths: $baths, type: $type, minArea: $minArea, amenities: $amenities, sort: $sort, swLat: $swLat, swLng: $swLng, neLat: $neLat, neLng: $neLng)';
}


}

/// @nodoc
abstract mixin class $SearchFiltersCopyWith<$Res>  {
  factory $SearchFiltersCopyWith(SearchFilters value, $Res Function(SearchFilters) _then) = _$SearchFiltersCopyWithImpl;
@useResult
$Res call({
 String dealType, String? q, num? minPrice, num? maxPrice, int? beds, int? baths, String? type, num? minArea, List<String> amenities, String sort, double? swLat, double? swLng, double? neLat, double? neLng
});




}
/// @nodoc
class _$SearchFiltersCopyWithImpl<$Res>
    implements $SearchFiltersCopyWith<$Res> {
  _$SearchFiltersCopyWithImpl(this._self, this._then);

  final SearchFilters _self;
  final $Res Function(SearchFilters) _then;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dealType = null,Object? q = freezed,Object? minPrice = freezed,Object? maxPrice = freezed,Object? beds = freezed,Object? baths = freezed,Object? type = freezed,Object? minArea = freezed,Object? amenities = null,Object? sort = null,Object? swLat = freezed,Object? swLng = freezed,Object? neLat = freezed,Object? neLng = freezed,}) {
  return _then(_self.copyWith(
dealType: null == dealType ? _self.dealType : dealType // ignore: cast_nullable_to_non_nullable
as String,q: freezed == q ? _self.q : q // ignore: cast_nullable_to_non_nullable
as String?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as num?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as num?,beds: freezed == beds ? _self.beds : beds // ignore: cast_nullable_to_non_nullable
as int?,baths: freezed == baths ? _self.baths : baths // ignore: cast_nullable_to_non_nullable
as int?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,minArea: freezed == minArea ? _self.minArea : minArea // ignore: cast_nullable_to_non_nullable
as num?,amenities: null == amenities ? _self.amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<String>,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as String,swLat: freezed == swLat ? _self.swLat : swLat // ignore: cast_nullable_to_non_nullable
as double?,swLng: freezed == swLng ? _self.swLng : swLng // ignore: cast_nullable_to_non_nullable
as double?,neLat: freezed == neLat ? _self.neLat : neLat // ignore: cast_nullable_to_non_nullable
as double?,neLng: freezed == neLng ? _self.neLng : neLng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchFilters].
extension SearchFiltersPatterns on SearchFilters {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchFilters value)  $default,){
final _that = this;
switch (_that) {
case _SearchFilters():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchFilters value)?  $default,){
final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String dealType,  String? q,  num? minPrice,  num? maxPrice,  int? beds,  int? baths,  String? type,  num? minArea,  List<String> amenities,  String sort,  double? swLat,  double? swLng,  double? neLat,  double? neLng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
return $default(_that.dealType,_that.q,_that.minPrice,_that.maxPrice,_that.beds,_that.baths,_that.type,_that.minArea,_that.amenities,_that.sort,_that.swLat,_that.swLng,_that.neLat,_that.neLng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String dealType,  String? q,  num? minPrice,  num? maxPrice,  int? beds,  int? baths,  String? type,  num? minArea,  List<String> amenities,  String sort,  double? swLat,  double? swLng,  double? neLat,  double? neLng)  $default,) {final _that = this;
switch (_that) {
case _SearchFilters():
return $default(_that.dealType,_that.q,_that.minPrice,_that.maxPrice,_that.beds,_that.baths,_that.type,_that.minArea,_that.amenities,_that.sort,_that.swLat,_that.swLng,_that.neLat,_that.neLng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String dealType,  String? q,  num? minPrice,  num? maxPrice,  int? beds,  int? baths,  String? type,  num? minArea,  List<String> amenities,  String sort,  double? swLat,  double? swLng,  double? neLat,  double? neLng)?  $default,) {final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
return $default(_that.dealType,_that.q,_that.minPrice,_that.maxPrice,_that.beds,_that.baths,_that.type,_that.minArea,_that.amenities,_that.sort,_that.swLat,_that.swLng,_that.neLat,_that.neLng);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchFilters extends SearchFilters {
  const _SearchFilters({this.dealType = 'buy', this.q, this.minPrice, this.maxPrice, this.beds, this.baths, this.type, this.minArea, final  List<String> amenities = const <String>[], this.sort = 'newest', this.swLat, this.swLng, this.neLat, this.neLng}): _amenities = amenities,super._();
  factory _SearchFilters.fromJson(Map<String, dynamic> json) => _$SearchFiltersFromJson(json);

@override@JsonKey() final  String dealType;
@override final  String? q;
@override final  num? minPrice;
@override final  num? maxPrice;
@override final  int? beds;
@override final  int? baths;
@override final  String? type;
@override final  num? minArea;
 final  List<String> _amenities;
@override@JsonKey() List<String> get amenities {
  if (_amenities is EqualUnmodifiableListView) return _amenities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_amenities);
}

@override@JsonKey() final  String sort;
@override final  double? swLat;
@override final  double? swLng;
@override final  double? neLat;
@override final  double? neLng;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchFiltersCopyWith<_SearchFilters> get copyWith => __$SearchFiltersCopyWithImpl<_SearchFilters>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchFiltersToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchFilters&&(identical(other.dealType, dealType) || other.dealType == dealType)&&(identical(other.q, q) || other.q == q)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.beds, beds) || other.beds == beds)&&(identical(other.baths, baths) || other.baths == baths)&&(identical(other.type, type) || other.type == type)&&(identical(other.minArea, minArea) || other.minArea == minArea)&&const DeepCollectionEquality().equals(other._amenities, _amenities)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.swLat, swLat) || other.swLat == swLat)&&(identical(other.swLng, swLng) || other.swLng == swLng)&&(identical(other.neLat, neLat) || other.neLat == neLat)&&(identical(other.neLng, neLng) || other.neLng == neLng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dealType,q,minPrice,maxPrice,beds,baths,type,minArea,const DeepCollectionEquality().hash(_amenities),sort,swLat,swLng,neLat,neLng);

@override
String toString() {
  return 'SearchFilters(dealType: $dealType, q: $q, minPrice: $minPrice, maxPrice: $maxPrice, beds: $beds, baths: $baths, type: $type, minArea: $minArea, amenities: $amenities, sort: $sort, swLat: $swLat, swLng: $swLng, neLat: $neLat, neLng: $neLng)';
}


}

/// @nodoc
abstract mixin class _$SearchFiltersCopyWith<$Res> implements $SearchFiltersCopyWith<$Res> {
  factory _$SearchFiltersCopyWith(_SearchFilters value, $Res Function(_SearchFilters) _then) = __$SearchFiltersCopyWithImpl;
@override @useResult
$Res call({
 String dealType, String? q, num? minPrice, num? maxPrice, int? beds, int? baths, String? type, num? minArea, List<String> amenities, String sort, double? swLat, double? swLng, double? neLat, double? neLng
});




}
/// @nodoc
class __$SearchFiltersCopyWithImpl<$Res>
    implements _$SearchFiltersCopyWith<$Res> {
  __$SearchFiltersCopyWithImpl(this._self, this._then);

  final _SearchFilters _self;
  final $Res Function(_SearchFilters) _then;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dealType = null,Object? q = freezed,Object? minPrice = freezed,Object? maxPrice = freezed,Object? beds = freezed,Object? baths = freezed,Object? type = freezed,Object? minArea = freezed,Object? amenities = null,Object? sort = null,Object? swLat = freezed,Object? swLng = freezed,Object? neLat = freezed,Object? neLng = freezed,}) {
  return _then(_SearchFilters(
dealType: null == dealType ? _self.dealType : dealType // ignore: cast_nullable_to_non_nullable
as String,q: freezed == q ? _self.q : q // ignore: cast_nullable_to_non_nullable
as String?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as num?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as num?,beds: freezed == beds ? _self.beds : beds // ignore: cast_nullable_to_non_nullable
as int?,baths: freezed == baths ? _self.baths : baths // ignore: cast_nullable_to_non_nullable
as int?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,minArea: freezed == minArea ? _self.minArea : minArea // ignore: cast_nullable_to_non_nullable
as num?,amenities: null == amenities ? _self._amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<String>,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as String,swLat: freezed == swLat ? _self.swLat : swLat // ignore: cast_nullable_to_non_nullable
as double?,swLng: freezed == swLng ? _self.swLng : swLng // ignore: cast_nullable_to_non_nullable
as double?,neLat: freezed == neLat ? _self.neLat : neLat // ignore: cast_nullable_to_non_nullable
as double?,neLng: freezed == neLng ? _self.neLng : neLng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
