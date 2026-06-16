import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/saved_search.dart';
import '../../../shared/widgets/state_views.dart';
import '../../auth/application/auth_controller.dart';
import '../../search/application/search_controller.dart';
import '../application/saved_searches_controller.dart';

class SavedSearchesScreen extends ConsumerWidget {
  const SavedSearchesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authed = ref.watch(isAuthenticatedProvider);
    final searches = ref.watch(savedSearchesControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Saved searches')),
      body: !authed
          ? EmptyView(
              icon: Icons.bookmark_border,
              title: 'Sign in to use saved searches',
              action: FilledButton(
                onPressed: () => context.pushNamed(Routes.login),
                child: const Text('Sign in'),
              ),
            )
          : searches.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => ErrorView(
                message: e.toString(),
                onRetry: () =>
                    ref.invalidate(savedSearchesControllerProvider),
              ),
              data: (list) {
                if (list.isEmpty) {
                  return EmptyView(
                    icon: Icons.bookmark_border,
                    title: 'No saved searches',
                    message:
                        'Save a search from the search screen to re-run it here.',
                    action: FilledButton(
                      onPressed: () => context.goNamed(Routes.search),
                      child: const Text('Start searching'),
                    ),
                  );
                }
                return ListView.separated(
                  padding: AppSpacing.pageAll,
                  itemCount: list.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, i) => _SavedSearchTile(search: list[i]),
                );
              },
            ),
    );
  }
}

class _SavedSearchTile extends ConsumerWidget {
  const _SavedSearchTile({required this.search});
  final SavedSearch search;

  String _summary() {
    final f = search.filters;
    final parts = <String>[
      f.dealType == 'rent' ? 'Rent' : 'Buy',
      if (f.type != null) f.type!,
      if (f.beds != null) '${f.beds}+ bd',
      if (f.maxPrice != null) '≤ ${Formatters.currency(f.maxPrice!)}',
      if (f.q != null) 'in ${f.q}',
    ];
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
        leading: const CircleAvatar(child: Icon(Icons.saved_search)),
        title: Text(search.label),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: AppSpacing.xs),
          child: Text(_summary()),
        ),
        trailing: FilledButton.tonal(
          onPressed: () {
            ref
                .read(searchControllerProvider.notifier)
                .runFilters(search.filters);
            context.goNamed(Routes.search);
          },
          child: const Text('Run'),
        ),
      ),
    );
  }
}
