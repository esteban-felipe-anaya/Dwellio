import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

/// An in-app notification (price drop, tour confirmation, new match, …).
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String title,
    @Default('') String body,
    @Default('system') String type, // price_drop | tour | match | system
    @Default(false) bool read,
    String? date,
    String? listingId,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
