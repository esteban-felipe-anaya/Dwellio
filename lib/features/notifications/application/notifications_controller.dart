import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/app_notification.dart';
import '../../../data/repositories/notification_repository.dart';

part 'notifications_controller.g.dart';

/// In-app notifications. Read/unread state is tracked locally (the mock API is
/// read-only for notifications).
@riverpod
class NotificationsController extends _$NotificationsController {
  @override
  Future<List<AppNotification>> build() =>
      ref.read(notificationRepositoryProvider).all();

  void markRead(String id) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData([
      for (final n in current)
        if (n.id == id) n.copyWith(read: true) else n,
    ]);
  }

  void markAllRead() {
    final current = state.value;
    if (current == null) return;
    state = AsyncData([for (final n in current) n.copyWith(read: true)]);
  }
}

/// Count of unread notifications — drives the nav bar badge.
@riverpod
int unreadNotificationCount(Ref ref) {
  final notifications = ref.watch(notificationsControllerProvider);
  return notifications.value?.where((n) => !n.read).length ?? 0;
}
