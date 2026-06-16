// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inquiry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InquiryMessage {

 String get from; String get text; String? get at;
/// Create a copy of InquiryMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InquiryMessageCopyWith<InquiryMessage> get copyWith => _$InquiryMessageCopyWithImpl<InquiryMessage>(this as InquiryMessage, _$identity);

  /// Serializes this InquiryMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InquiryMessage&&(identical(other.from, from) || other.from == from)&&(identical(other.text, text) || other.text == text)&&(identical(other.at, at) || other.at == at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,text,at);

@override
String toString() {
  return 'InquiryMessage(from: $from, text: $text, at: $at)';
}


}

/// @nodoc
abstract mixin class $InquiryMessageCopyWith<$Res>  {
  factory $InquiryMessageCopyWith(InquiryMessage value, $Res Function(InquiryMessage) _then) = _$InquiryMessageCopyWithImpl;
@useResult
$Res call({
 String from, String text, String? at
});




}
/// @nodoc
class _$InquiryMessageCopyWithImpl<$Res>
    implements $InquiryMessageCopyWith<$Res> {
  _$InquiryMessageCopyWithImpl(this._self, this._then);

  final InquiryMessage _self;
  final $Res Function(InquiryMessage) _then;

/// Create a copy of InquiryMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? text = null,Object? at = freezed,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,at: freezed == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InquiryMessage].
extension InquiryMessagePatterns on InquiryMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InquiryMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InquiryMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InquiryMessage value)  $default,){
final _that = this;
switch (_that) {
case _InquiryMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InquiryMessage value)?  $default,){
final _that = this;
switch (_that) {
case _InquiryMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String from,  String text,  String? at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InquiryMessage() when $default != null:
return $default(_that.from,_that.text,_that.at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String from,  String text,  String? at)  $default,) {final _that = this;
switch (_that) {
case _InquiryMessage():
return $default(_that.from,_that.text,_that.at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String from,  String text,  String? at)?  $default,) {final _that = this;
switch (_that) {
case _InquiryMessage() when $default != null:
return $default(_that.from,_that.text,_that.at);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InquiryMessage extends InquiryMessage {
  const _InquiryMessage({required this.from, required this.text, this.at}): super._();
  factory _InquiryMessage.fromJson(Map<String, dynamic> json) => _$InquiryMessageFromJson(json);

@override final  String from;
@override final  String text;
@override final  String? at;

/// Create a copy of InquiryMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InquiryMessageCopyWith<_InquiryMessage> get copyWith => __$InquiryMessageCopyWithImpl<_InquiryMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InquiryMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InquiryMessage&&(identical(other.from, from) || other.from == from)&&(identical(other.text, text) || other.text == text)&&(identical(other.at, at) || other.at == at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,text,at);

@override
String toString() {
  return 'InquiryMessage(from: $from, text: $text, at: $at)';
}


}

/// @nodoc
abstract mixin class _$InquiryMessageCopyWith<$Res> implements $InquiryMessageCopyWith<$Res> {
  factory _$InquiryMessageCopyWith(_InquiryMessage value, $Res Function(_InquiryMessage) _then) = __$InquiryMessageCopyWithImpl;
@override @useResult
$Res call({
 String from, String text, String? at
});




}
/// @nodoc
class __$InquiryMessageCopyWithImpl<$Res>
    implements _$InquiryMessageCopyWith<$Res> {
  __$InquiryMessageCopyWithImpl(this._self, this._then);

  final _InquiryMessage _self;
  final $Res Function(_InquiryMessage) _then;

/// Create a copy of InquiryMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? text = null,Object? at = freezed,}) {
  return _then(_InquiryMessage(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,at: freezed == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Inquiry {

 String get id; String get listingId; String get type; String get lastMessage; String get status; String? get date; List<InquiryMessage> get messages;
/// Create a copy of Inquiry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InquiryCopyWith<Inquiry> get copyWith => _$InquiryCopyWithImpl<Inquiry>(this as Inquiry, _$identity);

  /// Serializes this Inquiry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Inquiry&&(identical(other.id, id) || other.id == id)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.type, type) || other.type == type)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.messages, messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,listingId,type,lastMessage,status,date,const DeepCollectionEquality().hash(messages));

@override
String toString() {
  return 'Inquiry(id: $id, listingId: $listingId, type: $type, lastMessage: $lastMessage, status: $status, date: $date, messages: $messages)';
}


}

/// @nodoc
abstract mixin class $InquiryCopyWith<$Res>  {
  factory $InquiryCopyWith(Inquiry value, $Res Function(Inquiry) _then) = _$InquiryCopyWithImpl;
@useResult
$Res call({
 String id, String listingId, String type, String lastMessage, String status, String? date, List<InquiryMessage> messages
});




}
/// @nodoc
class _$InquiryCopyWithImpl<$Res>
    implements $InquiryCopyWith<$Res> {
  _$InquiryCopyWithImpl(this._self, this._then);

  final Inquiry _self;
  final $Res Function(Inquiry) _then;

/// Create a copy of Inquiry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? listingId = null,Object? type = null,Object? lastMessage = null,Object? status = null,Object? date = freezed,Object? messages = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<InquiryMessage>,
  ));
}

}


/// Adds pattern-matching-related methods to [Inquiry].
extension InquiryPatterns on Inquiry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Inquiry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Inquiry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Inquiry value)  $default,){
final _that = this;
switch (_that) {
case _Inquiry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Inquiry value)?  $default,){
final _that = this;
switch (_that) {
case _Inquiry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String listingId,  String type,  String lastMessage,  String status,  String? date,  List<InquiryMessage> messages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Inquiry() when $default != null:
return $default(_that.id,_that.listingId,_that.type,_that.lastMessage,_that.status,_that.date,_that.messages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String listingId,  String type,  String lastMessage,  String status,  String? date,  List<InquiryMessage> messages)  $default,) {final _that = this;
switch (_that) {
case _Inquiry():
return $default(_that.id,_that.listingId,_that.type,_that.lastMessage,_that.status,_that.date,_that.messages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String listingId,  String type,  String lastMessage,  String status,  String? date,  List<InquiryMessage> messages)?  $default,) {final _that = this;
switch (_that) {
case _Inquiry() when $default != null:
return $default(_that.id,_that.listingId,_that.type,_that.lastMessage,_that.status,_that.date,_that.messages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Inquiry extends Inquiry {
  const _Inquiry({required this.id, required this.listingId, this.type = 'message', this.lastMessage = '', this.status = 'open', this.date, final  List<InquiryMessage> messages = const <InquiryMessage>[]}): _messages = messages,super._();
  factory _Inquiry.fromJson(Map<String, dynamic> json) => _$InquiryFromJson(json);

@override final  String id;
@override final  String listingId;
@override@JsonKey() final  String type;
@override@JsonKey() final  String lastMessage;
@override@JsonKey() final  String status;
@override final  String? date;
 final  List<InquiryMessage> _messages;
@override@JsonKey() List<InquiryMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of Inquiry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InquiryCopyWith<_Inquiry> get copyWith => __$InquiryCopyWithImpl<_Inquiry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InquiryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Inquiry&&(identical(other.id, id) || other.id == id)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.type, type) || other.type == type)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._messages, _messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,listingId,type,lastMessage,status,date,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'Inquiry(id: $id, listingId: $listingId, type: $type, lastMessage: $lastMessage, status: $status, date: $date, messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$InquiryCopyWith<$Res> implements $InquiryCopyWith<$Res> {
  factory _$InquiryCopyWith(_Inquiry value, $Res Function(_Inquiry) _then) = __$InquiryCopyWithImpl;
@override @useResult
$Res call({
 String id, String listingId, String type, String lastMessage, String status, String? date, List<InquiryMessage> messages
});




}
/// @nodoc
class __$InquiryCopyWithImpl<$Res>
    implements _$InquiryCopyWith<$Res> {
  __$InquiryCopyWithImpl(this._self, this._then);

  final _Inquiry _self;
  final $Res Function(_Inquiry) _then;

/// Create a copy of Inquiry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? listingId = null,Object? type = null,Object? lastMessage = null,Object? status = null,Object? date = freezed,Object? messages = null,}) {
  return _then(_Inquiry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<InquiryMessage>,
  ));
}


}

// dart format on
