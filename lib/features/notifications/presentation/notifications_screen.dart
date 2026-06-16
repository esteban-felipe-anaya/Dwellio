import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/app_notification.dart';
import '../../../shared/widgets/state_views.dart';
import '../application/notifications_controller.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () =>
                ref.read(notificationsControllerProvider.notifier).markAllRead(),
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: notifications.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(notificationsControllerProvider),
        ),
        data: (list) {
          if (list.isEmpty) {
            return const EmptyView(
              icon: Icons.notifications_none,
              title: "You're all caught up",
              message: 'New matches, price drops and tour updates will show here.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            itemCount: list.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, i) =>
                _NotificationTile(notification: list[i]),
          );
        },
      ),
    );
  }
}

class _NotificationTile extends ConsumerWidget {
  const _NotificationTile({required this.notification});
  final AppNotification notification;

  IconData _iconFor(String type) => switch (type) {
        'price_drop' => Icons.trending_down,
        'tour' => Icons.event_available_outlined,
        'match' => Icons.auto_awesome_outlined,
        _ => Icons.notifications_outlined,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final unread = !notification.read;
    return ListTile(
      tileColor:
          unread ? theme.colorScheme.surfaceContainerHighest : null,
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.secondaryContainer,
        child: Icon(_iconFor(notification.type),
            color: theme.colorScheme.onSecondaryContainer),
      ),
      title: Text(notification.title,
          style: TextStyle(
              fontWeight: unread ? FontWeight.bold : FontWeight.normal)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(notification.body),
          const SizedBox(height: AppSpacing.xs),
          Text(Formatters.date(notification.date),
              style: theme.textTheme.bodySmall),
        ],
      ),
      isThreeLine: true,
      trailing: unread
          ? Icon(Icons.circle, size: 10, color: theme.colorScheme.primary)
          : null,
      onTap: () {
        ref
            .read(notificationsControllerProvider.notifier)
            .markRead(notification.id);
        if (notification.listingId != null) {
          context.pushNamed(Routes.listing,
              pathParameters: {'id': notification.listingId!});
        }
      },
    );
  }
}
