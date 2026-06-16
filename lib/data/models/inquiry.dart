import 'package:freezed_annotation/freezed_annotation.dart';

part 'inquiry.freezed.dart';
part 'inquiry.g.dart';

/// A single message within an inquiry thread.
@freezed
abstract class InquiryMessage with _$InquiryMessage {
  const factory InquiryMessage({
    required String from, // 'user' | 'agent'
    required String text,
    String? at,
  }) = _InquiryMessage;

  const InquiryMessage._();

  factory InquiryMessage.fromJson(Map<String, dynamic> json) =>
      _$InquiryMessageFromJson(json);

  bool get isFromUser => from == 'user';
}

/// A tour request or message thread with an agent, surfaced in My Inquiries.
@freezed
abstract class Inquiry with _$Inquiry {
  const factory Inquiry({
    required String id,
    required String listingId,
    @Default('message') String type, // 'tour' | 'message'
    @Default('') String lastMessage,
    @Default('open') String status,
    String? date,
    @Default(<InquiryMessage>[]) List<InquiryMessage> messages,
  }) = _Inquiry;

  const Inquiry._();

  factory Inquiry.fromJson(Map<String, dynamic> json) =>
      _$InquiryFromJson(json);

  bool get isTour => type == 'tour';
}
