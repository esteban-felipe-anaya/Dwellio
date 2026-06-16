// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inquiry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InquiryMessage _$InquiryMessageFromJson(Map<String, dynamic> json) =>
    _InquiryMessage(
      from: json['from'] as String,
      text: json['text'] as String,
      at: json['at'] as String?,
    );

Map<String, dynamic> _$InquiryMessageToJson(_InquiryMessage instance) =>
    <String, dynamic>{
      'from': instance.from,
      'text': instance.text,
      'at': instance.at,
    };

_Inquiry _$InquiryFromJson(Map<String, dynamic> json) => _Inquiry(
  id: json['id'] as String,
  listingId: json['listingId'] as String,
  type: json['type'] as String? ?? 'message',
  lastMessage: json['lastMessage'] as String? ?? '',
  status: json['status'] as String? ?? 'open',
  date: json['date'] as String?,
  messages:
      (json['messages'] as List<dynamic>?)
          ?.map((e) => InquiryMessage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <InquiryMessage>[],
);

Map<String, dynamic> _$InquiryToJson(_Inquiry instance) => <String, dynamic>{
  'id': instance.id,
  'listingId': instance.listingId,
  'type': instance.type,
  'lastMessage': instance.lastMessage,
  'status': instance.status,
  'date': instance.date,
  'messages': instance.messages,
};
