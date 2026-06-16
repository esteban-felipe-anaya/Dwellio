import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/inquiry.dart';
import '../../../data/repositories/listing_repository.dart';
import '../../../shared/widgets/state_views.dart';
import '../../auth/application/auth_controller.dart';
import '../application/inquiries_controller.dart';
import 'inquiry_thread_screen.dart';

class InquiriesScreen extends ConsumerWidget {
  const InquiriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authed = ref.watch(isAuthenticatedProvider);
    final inquiries = ref.watch(inquiriesControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My inquiries')),
      body: !authed
          ? EmptyView(
              icon: Icons.forum_outlined,
              title: 'Sign in to view inquiries',
              message: 'Your tours and agent conversations appear here.',
              action: FilledButton(
                onPressed: () => context.pushNamed(Routes.login),
                child: const Text('Sign in'),
              ),
            )
          : inquiries.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => ErrorView(
                message: e.toString(),
                onRetry: () => ref.invalidate(inquiriesControllerProvider),
              ),
              data: (list) {
                if (list.isEmpty) {
                  return EmptyView(
                    icon: Icons.forum_outlined,
                    title: 'No inquiries yet',
                    message:
                        'Schedule a tour or message an agent to get started.',
                    action: FilledButton(
                      onPressed: () => context.goNamed(Routes.search),
                      child: const Text('Find a home'),
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async =>
                      ref.invalidate(inquiriesControllerProvider),
                  child: ListView.separated(
                    padding: AppSpacing.pageAll,
                    itemCount: list.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, i) => _InquiryTile(inquiry: list[i]),
                  ),
                );
              },
            ),
    );
  }
}

class _InquiryTile extends ConsumerWidget {
  const _InquiryTile({required this.inquiry});
  final Inquiry inquiry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final listing = ref.watch(listingProvider(inquiry.listingId));
    final title = listing.maybeWhen(
        data: (l) => l.title, orElse: () => 'Listing ${inquiry.listingId}');

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
        leading: CircleAvatar(
          backgroundColor: inquiry.isTour
              ? theme.colorScheme.tertiaryContainer
              : theme.colorScheme.secondaryContainer,
          child: Icon(
            inquiry.isTour
                ? Icons.event_available_outlined
                : Icons.chat_bubble_outline,
            color: inquiry.isTour
                ? theme.colorScheme.onTertiaryContainer
                : theme.colorScheme.onSecondaryContainer,
          ),
        ),
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(inquiry.lastMessage,
                maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                _StatusChip(status: inquiry.status),
                const SizedBox(width: AppSpacing.sm),
                Text(Formatters.date(inquiry.date),
                    style: theme.textTheme.bodySmall),
              ],
            ),
          ],
        ),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                InquiryThreadScreen(inquiry: inquiry, listingTitle: title),
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final confirmed = status == 'confirmed';
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: confirmed ? scheme.primaryContainer : scheme.surfaceContainerHighest,
        borderRadius: AppRadii.chipRadius,
      ),
      child: Text(
        status[0].toUpperCase() + status.substring(1),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color:
                  confirmed ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
            ),
      ),
    );
  }
}
