import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/auth_guard.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/app_icons.dart';
import '../../../data/models/search_filters.dart';
import '../../../data/repositories/listing_repository.dart';
import '../../../shared/widgets/listing_card.dart';
import '../../../shared/widgets/state_views.dart';
import '../../notifications/application/notifications_controller.dart';
import '../../search/application/search_controller.dart';

/// Home: search entry, Buy/Rent toggle, property-type shortcuts, featured
/// listings rail and "explore by city". Everything routes into Search.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _searchWith(WidgetRef ref, BuildContext context, SearchFilters filters) {
    ref.read(searchControllerProvider.notifier).applyFilters(filters);
    context.goNamed(Routes.search);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealType = ref.watch(
        searchControllerProvider.select((s) => s.filters.dealType));
    final unread = ref.watch(unreadNotificationCountProvider);
    final featured = ref.watch(featuredListingsProvider);
    final types = ref.watch(propertyTypesProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: const Text('Dwellio',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              actions: [
                IconButton(
                  tooltip: 'Notifications',
                  onPressed: () => context.pushNamed(Routes.notifications),
                  icon: unread > 0
                      ? Badge(label: Text('$unread'), child: const Icon(Icons.notifications_outlined))
                      : const Icon(Icons.notifications_outlined),
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
            ),
            SliverPadding(
              padding: AppSpacing.pageAll,
              sliver: SliverList.list(
                children: [
                  Text('Find your next home',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: AppSpacing.md),
                  // Search entry — tapping routes to Search.
                  SearchBar(
                    leading: const Icon(Icons.search),
                    hintText: 'City, neighborhood or address',
                    onTap: () => context.goNamed(Routes.search),
                    onSubmitted: (q) => _searchWith(
                        ref,
                        context,
                        SearchFilters(dealType: dealType, q: q.isEmpty ? null : q)),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // Buy / Rent toggle
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(
                          value: 'buy',
                          label: Text('Buy'),
                          icon: Icon(Icons.sell_outlined)),
                      ButtonSegment(
                          value: 'rent',
                          label: Text('Rent'),
                          icon: Icon(Icons.vpn_key_outlined)),
                    ],
                    selected: {dealType},
                    onSelectionChanged: (s) => ref
                        .read(searchControllerProvider.notifier)
                        .setDealType(s.first),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Property-type shortcuts
                  Text('Browse by type',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.md),
                  types.when(
                    loading: () => const SizedBox(
                        height: 92, child: Center(child: CircularProgressIndicator())),
                    error: (_, _) => const SizedBox.shrink(),
                    data: (list) => SizedBox(
                      height: 96,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(width: AppSpacing.md),
                        itemBuilder: (context, i) {
                          final t = list[i];
                          return _TypeShortcut(
                            icon: AppIcons.resolve(t.icon),
                            label: t.name,
                            onTap: () => _searchWith(ref, context,
                                SearchFilters(dealType: dealType, type: t.id)),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Sell CTA
                  _SellBanner(
                    onTap: () => AuthGuard.run(ref, context,
                        () async => context.pushNamed(Routes.sell)),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    children: [
                      Text('Featured homes',
                          style: Theme.of(context).textTheme.titleMedium),
                      const Spacer(),
                      TextButton(
                        onPressed: () => context.goNamed(Routes.search),
                        child: const Text('See all'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ),
            ),
            // Featured rail
            SliverToBoxAdapter(
              child: SizedBox(
                height: 300,
                child: featured.when(
                  loading: () => ListView(
                    scrollDirection: Axis.horizontal,
                    padding: AppSpacing.pageH,
                    children: const [
                      SizedBox(width: 260, child: ListingCardSkeleton()),
                      SizedBox(width: AppSpacing.lg),
                      SizedBox(width: 260, child: ListingCardSkeleton()),
                    ],
                  ),
                  error: (e, _) => ErrorView(
                    message: e.toString(),
                    onRetry: () => ref.invalidate(featuredListingsProvider),
                  ),
                  data: (list) {
                    if (list.isEmpty) {
                      return const EmptyView(
                          icon: Icons.home_outlined,
                          title: 'No featured homes right now');
                    }
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: AppSpacing.pageH,
                      itemCount: list.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: AppSpacing.lg),
                      itemBuilder: (context, i) => ListingCardCompact(
                        listing: list[i],
                        onTap: () =>
                            context.pushNamed(Routes.listing, pathParameters: {'id': list[i].id}),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: AppSpacing.pageAll,
              sliver: SliverList.list(children: [
                const SizedBox(height: AppSpacing.sm),
                Text('Explore by city',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: [
                    for (final city in const ['Austin', 'CDMX', 'Lisbon'])
                      ActionChip(
                        avatar: const Icon(Icons.location_city, size: 18),
                        label: Text(city),
                        onPressed: () => _searchWith(ref, context,
                            SearchFilters(dealType: dealType, q: city)),
                      ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeShortcut extends StatelessWidget {
  const _TypeShortcut(
      {required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: SizedBox(
        width: 84,
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: scheme.secondaryContainer,
              child: Icon(icon, color: scheme.onSecondaryContainer),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}

class _SellBanner extends StatelessWidget {
  const _SellBanner({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.tertiaryContainer,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: AppSpacing.pageAll,
          child: Row(
            children: [
              Icon(Icons.add_home_work_outlined,
                  size: 40, color: scheme.onTertiaryContainer),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('List your property',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: scheme.onTertiaryContainer)),
                    Text('Reach thousands of buyers and renters.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onTertiaryContainer)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: scheme.onTertiaryContainer),
            ],
          ),
        ),
      ),
    );
  }
}
