import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/guard.dart';
import '../../core/providers/core_providers.dart';
import '../api/dwellio_api.dart';
import '../models/app_notification.dart';

/// Read access to in-app notifications.
class NotificationRepository {
  NotificationRepository(this._api);

  final DwellioApi _api;

  Future<List<AppNotification>> all() => guard(() => _api.notifications());
}

final notificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) => NotificationRepository(ref.watch(dwellioApiProvider)),
);
