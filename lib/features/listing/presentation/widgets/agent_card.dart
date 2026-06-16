import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../data/repositories/listing_repository.dart';
import '../../../../shared/widgets/app_network_image.dart';

/// Agent summary with rating and call / message actions.
class AgentCard extends ConsumerWidget {
  const AgentCard({
    super.key,
    required this.agentId,
    required this.onMessage,
  });

  final String agentId;
  final VoidCallback onMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agent = ref.watch(agentProvider(agentId));
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: AppSpacing.pageAll,
        child: agent.when(
          loading: () => const SizedBox(
              height: 72, child: Center(child: CircularProgressIndicator())),
          error: (_, _) => const Text('Agent details unavailable'),
          data: (a) => Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadii.md),
                    child: SizedBox(
                      width: AppSizes.agentAvatar,
                      height: AppSizes.agentAvatar,
                      child: AppNetworkImage(url: a.photo ?? ''),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a.name, style: theme.textTheme.titleMedium),
                        Text(a.agency,
                            style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant)),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: a.rating.toDouble(),
                              itemCount: 5,
                              itemSize: 16,
                              itemBuilder: (_, _) =>
                                  const Icon(Icons.star, color: Colors.amber),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text('${a.rating} (${a.reviewCount})',
                                style: theme.textTheme.bodySmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Calling ${a.phone}…')),
                        );
                      },
                      icon: const Icon(Icons.call_outlined),
                      label: const Text('Call'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: onMessage,
                      icon: const Icon(Icons.chat_bubble_outline),
                      label: const Text('Message'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
