// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Listing {

 String get id; String get title; String get dealType; num get price; String get currency; String get propertyType; int get beds; int get baths; num get areaSqm; int get parking; String get address; String get city; double get lat; double get lng; List<String> get amenities; List<String> get photos; String get agentId; String get description; bool get featured; String? get listedAt;
/// Create a copy of Listing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingCopyWith<Listing> get copyWith => _$ListingCopyWithImpl<Listing>(this as Listing, _$identity);

  /// Serializes this Listing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Listing&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.dealType, dealType) || other.dealType == dealType)&&(identical(other.price, price) || other.price == price)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.propertyType, propertyType) || other.propertyType == propertyType)&&(identical(other.beds, beds) || other.beds == beds)&&(identical(other.baths, baths) || other.baths == baths)&&(identical(other.areaSqm, areaSqm) || other.areaSqm == areaSqm)&&(identical(other.parking, parking) || other.parking == parking)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&const DeepCollectionEquality().equals(other.amenities, amenities)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.agentId, agentId) || other.agentId == agentId)&&(identical(other.description, description) || other.description == description)&&(identical(other.featured, featured) || other.featured == featured)&&(identical(other.listedAt, listedAt) || other.listedAt == listedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,dealType,price,currency,propertyType,beds,baths,areaSqm,parking,address,city,lat,lng,const DeepCollectionEquality().hash(amenities),const DeepCollectionEquality().hash(photos),agentId,description,featured,listedAt]);

@override
String toString() {
  return 'Listing(id: $id, title: $title, dealType: $dealType, price: $price, currency: $currency, propertyType: $propertyType, beds: $beds, baths: $baths, areaSqm: $areaSqm, parking: $parking, address: $address, city: $city, lat: $lat, lng: $lng, amenities: $amenities, photos: $photos, agentId: $agentId, description: $description, featured: $featured, listedAt: $listedAt)';
}


}

/// @nodoc
abstract mixin class $ListingCopyWith<$Res>  {
  factory $ListingCopyWith(Listing value, $Res Function(Listing) _then) = _$ListingCopyWithImpl;
@useResult
$Res call({
 String id, String title, String dealType, num price, String currency, String propertyType, int beds, int baths, num areaSqm, int parking, String address, String city, double lat, double lng, List<String> amenities, List<String> photos, String agentId, String description, bool featured, String? listedAt
});




}
/// @nodoc
class _$ListingCopyWithImpl<$Res>
    implements $ListingCopyWith<$Res> {
  _$ListingCopyWithImpl(this._self, this._then);

  final Listing _self;
  final $Res Function(Listing) _then;

/// Create a copy of Listing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? dealType = null,Object? price = null,Object? currency = null,Object? propertyType = null,Object? beds = null,Object? baths = null,Object? areaSqm = null,Object? parking = null,Object? address = null,Object? city = null,Object? lat = null,Object? lng = null,Object? amenities = null,Object? photos = null,Object? agentId = null,Object? description = null,Object? featured = null,Object? listedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,dealType: null == dealType ? _self.dealType : dealType // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,propertyType: null == propertyType ? _self.propertyType : propertyType // ignore: cast_nullable_to_non_nullable
as String,beds: null == beds ? _self.beds : beds // ignore: cast_nullable_to_non_nullable
as int,baths: null == baths ? _self.baths : baths // ignore: cast_nullable_to_non_nullable
as int,areaSqm: null == areaSqm ? _self.areaSqm : areaSqm // ignore: cast_nullable_to_non_nullable
as num,parking: null == parking ? _self.parking : parking // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,amenities: null == amenities ? _self.amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<String>,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,agentId: null == agentId ? _self.agentId : agentId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,featured: null == featured ? _self.featured : featured // ignore: cast_nullable_to_non_nullable
as bool,listedAt: freezed == listedAt ? _self.listedAt : listedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Listing].
extension ListingPatterns on Listing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Listing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Listing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Listing value)  $default,){
final _that = this;
switch (_that) {
case _Listing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Listing value)?  $default,){
final _that = this;
switch (_that) {
case _Listing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String dealType,  num price,  String currency,  String propertyType,  int beds,  int baths,  num areaSqm,  int parking,  String address,  String city,  double lat,  double lng,  List<String> amenities,  List<String> photos,  String agentId,  String description,  bool featured,  String? listedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Listing() when $default != null:
return $default(_that.id,_that.title,_that.dealType,_that.price,_that.currency,_that.propertyType,_that.beds,_that.baths,_that.areaSqm,_that.parking,_that.address,_that.city,_that.lat,_that.lng,_that.amenities,_that.photos,_that.agentId,_that.description,_that.featured,_that.listedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String dealType,  num price,  String currency,  String propertyType,  int beds,  int baths,  num areaSqm,  int parking,  String address,  String city,  double lat,  double lng,  List<String> amenities,  List<String> photos,  String agentId,  String description,  bool featured,  String? listedAt)  $default,) {final _that = this;
switch (_that) {
case _Listing():
return $default(_that.id,_that.title,_that.dealType,_that.price,_that.currency,_that.propertyType,_that.beds,_that.baths,_that.areaSqm,_that.parking,_that.address,_that.city,_that.lat,_that.lng,_that.amenities,_that.photos,_that.agentId,_that.description,_that.featured,_that.listedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String dealType,  num price,  String currency,  String propertyType,  int beds,  int baths,  num areaSqm,  int parking,  String address,  String city,  double lat,  double lng,  List<String> amenities,  List<String> photos,  String agentId,  String description,  bool featured,  String? listedAt)?  $default,) {final _that = this;
switch (_that) {
case _Listing() when $default != null:
return $default(_that.id,_that.title,_that.dealType,_that.price,_that.currency,_that.propertyType,_that.beds,_that.baths,_that.areaSqm,_that.parking,_that.address,_that.city,_that.lat,_that.lng,_that.amenities,_that.photos,_that.agentId,_that.description,_that.featured,_that.listedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Listing extends Listing {
  const _Listing({required this.id, required this.title, required this.dealType, required this.price, this.currency = 'USD', required this.propertyType, this.beds = 0, this.baths = 0, this.areaSqm = 0, this.parking = 0, this.address = '', this.city = '', required this.lat, required this.lng, final  List<String> amenities = const <String>[], final  List<String> photos = const <String>[], this.agentId = '', this.description = '', this.featured = false, this.listedAt}): _amenities = amenities,_photos = photos,super._();
  factory _Listing.fromJson(Map<String, dynamic> json) => _$ListingFromJson(json);

@override final  String id;
@override final  String title;
@override final  String dealType;
@override final  num price;
@override@JsonKey() final  String currency;
@override final  String propertyType;
@override@JsonKey() final  int beds;
@override@JsonKey() final  int baths;
@override@JsonKey() final  num areaSqm;
@override@JsonKey() final  int parking;
@override@JsonKey() final  String address;
@override@JsonKey() final  String city;
@override final  double lat;
@override final  double lng;
 final  List<String> _amenities;
@override@JsonKey() List<String> get amenities {
  if (_amenities is EqualUnmodifiableListView) return _amenities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_amenities);
}

 final  List<String> _photos;
@override@JsonKey() List<String> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override@JsonKey() final  String agentId;
@override@JsonKey() final  String description;
@override@JsonKey() final  bool featured;
@override final  String? listedAt;

/// Create a copy of Listing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingCopyWith<_Listing> get copyWith => __$ListingCopyWithImpl<_Listing>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Listing&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.dealType, dealType) || other.dealType == dealType)&&(identical(other.price, price) || other.price == price)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.propertyType, propertyType) || other.propertyType == propertyType)&&(identical(other.beds, beds) || other.beds == beds)&&(identical(other.baths, baths) || other.baths == baths)&&(identical(other.areaSqm, areaSqm) || other.areaSqm == areaSqm)&&(identical(other.parking, parking) || other.parking == parking)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&const DeepCollectionEquality().equals(other._amenities, _amenities)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.agentId, agentId) || other.agentId == agentId)&&(identical(other.description, description) || other.description == description)&&(identical(other.featured, featured) || other.featured == featured)&&(identical(other.listedAt, listedAt) || other.listedAt == listedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,dealType,price,currency,propertyType,beds,baths,areaSqm,parking,address,city,lat,lng,const DeepCollectionEquality().hash(_amenities),const DeepCollectionEquality().hash(_photos),agentId,description,featured,listedAt]);

@override
String toString() {
  return 'Listing(id: $id, title: $title, dealType: $dealType, price: $price, currency: $currency, propertyType: $propertyType, beds: $beds, baths: $baths, areaSqm: $areaSqm, parking: $parking, address: $address, city: $city, lat: $lat, lng: $lng, amenities: $amenities, photos: $photos, agentId: $agentId, description: $description, featured: $featured, listedAt: $listedAt)';
}


}

/// @nodoc
abstract mixin class _$ListingCopyWith<$Res> implements $ListingCopyWith<$Res> {
  factory _$ListingCopyWith(_Listing value, $Res Function(_Listing) _then) = __$ListingCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String dealType, num price, String currency, String propertyType, int beds, int baths, num areaSqm, int parking, String address, String city, double lat, double lng, List<String> amenities, List<String> photos, String agentId, String description, bool featured, String? listedAt
});




}
/// @nodoc
class __$ListingCopyWithImpl<$Res>
    implements _$ListingCopyWith<$Res> {
  __$ListingCopyWithImpl(this._self, this._then);

  final _Listing _self;
  final $Res Function(_Listing) _then;

/// Create a copy of Listing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? dealType = null,Object? price = null,Object? currency = null,Object? propertyType = null,Object? beds = null,Object? baths = null,Object? areaSqm = null,Object? parking = null,Object? address = null,Object? city = null,Object? lat = null,Object? lng = null,Object? amenities = null,Object? photos = null,Object? agentId = null,Object? description = null,Object? featured = null,Object? listedAt = freezed,}) {
  return _then(_Listing(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,dealType: null == dealType ? _self.dealType : dealType // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,propertyType: null == propertyType ? _self.propertyType : propertyType // ignore: cast_nullable_to_non_nullable
as String,beds: null == beds ? _self.beds : beds // ignore: cast_nullable_to_non_nullable
as int,baths: null == baths ? _self.baths : baths // ignore: cast_nullable_to_non_nullable
as int,areaSqm: null == areaSqm ? _self.areaSqm : areaSqm // ignore: cast_nullable_to_non_nullable
as num,parking: null == parking ? _self.parking : parking // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,amenities: null == amenities ? _self._amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<String>,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,agentId: null == agentId ? _self.agentId : agentId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,featured: null == featured ? _self.featured : featured // ignore: cast_nullable_to_non_nullable
as bool,listedAt: freezed == listedAt ? _self.listedAt : listedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
