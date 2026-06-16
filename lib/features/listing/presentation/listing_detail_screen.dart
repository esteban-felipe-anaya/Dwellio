import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/router/auth_guard.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/listing.dart';
import '../../../data/repositories/listing_repository.dart';
import '../../../shared/widgets/favorite_button.dart';
import '../../../shared/widgets/listing_card.dart';
import '../../../shared/widgets/price_tag.dart';
import '../../../shared/widgets/spec_chips.dart';
import '../../../shared/widgets/state_views.dart';
import 'widgets/agent_card.dart';
import 'widgets/amenities_grid.dart';
import 'widgets/contact_agent_sheet.dart';
import 'widgets/mini_map.dart';
import 'widgets/mortgage_calculator_card.dart';
import 'widgets/photo_gallery.dart';
import 'widgets/schedule_tour_sheet.dart';

class ListingDetailScreen extends ConsumerWidget {
  const ListingDetailScreen({super.key, required this.listingId});

  final String listingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listing = ref.watch(listingProvider(listingId));

    return Scaffold(
      body: listing.when(
        loading: () => const _DetailLoading(),
        error: (e, _) => Scaffold(
          appBar: AppBar(),
          body: ErrorView(
            message: e is ApiException ? e.message : e.toString(),
            onRetry: () => ref.invalidate(listingProvider(listingId)),
          ),
        ),
        data: (l) => _DetailBody(listing: l),
      ),
      bottomNavigationBar: listing.maybeWhen(
        data: (l) => _ActionBar(listing: l),
        orElse: () => null,
      ),
    );
  }
}

class _DetailBody extends ConsumerWidget {
  const _DetailBody({required this.listing});
  final Listing listing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final similar = ref.watch(similarListingsProvider(listing.id));

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 320,
          pinned: true,
          actions: [
            FavoriteButton(listingId: listing.id, filledBackground: true),
            const SizedBox(width: AppSpacing.sm),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: PhotoGallery(photos: listing.photos),
          ),
        ),
        SliverPadding(
          padding: AppSpacing.pageAll,
          sliver: SliverList.list(
            children: [
              Row(
                children: [
                  Expanded(
                    child: PriceTag(
                      listing: listing,
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DealTypeBadge(dealType: listing.dealType),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(listing.title, style: theme.textTheme.titleLarge),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Icon(Icons.place_outlined,
                      size: 18, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(listing.address,
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant)),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Card(
                child: Padding(
                  padding: AppSpacing.pageAll,
                  child: SpecChips(listing: listing, spacing: AppSpacing.xl),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (listing.listedAt != null)
                Text('Listed ${Formatters.date(listing.listedAt)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(height: AppSpacing.lg),
              _Section(
                title: 'About this home',
                child: Text(listing.description,
                    style: theme.textTheme.bodyLarge),
              ),
              _Section(
                title: 'Amenities',
                child: AmenitiesGrid(amenityIds: listing.amenities),
              ),
              _Section(
                title: 'Location',
                child: MiniMap(lat: listing.lat, lng: listing.lng),
              ),
              if (!listing.isRental) ...[
                const SizedBox(height: AppSpacing.sm),
                MortgageCalculatorCard(price: listing.price.toDouble()),
              ],
              _Section(
                title: 'Listed by',
                child: AgentCard(
                  agentId: listing.agentId,
                  onMessage: () => AuthGuard.run(ref, context,
                      () => ContactAgentSheet.show(context, listing.id)),
                ),
              ),
              Text('Similar homes', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 300,
            child: similar.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => const SizedBox.shrink(),
              data: (list) {
                if (list.isEmpty) {
                  return const Padding(
                    padding: AppSpacing.pageH,
                    child: Text('No similar homes found.'),
                  );
                }
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: AppSpacing.pageH,
                  itemCount: list.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: AppSpacing.lg),
                  itemBuilder: (context, i) => ListingCardCompact(
                    listing: list[i],
                    onTap: () => context.pushNamed(Routes.listing,
                        pathParameters: {'id': list[i].id}),
                  ),
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        child,
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}

/// Sticky bottom bar: contact agent + schedule tour (both auth-gated).
class _ActionBar extends ConsumerWidget {
  const _ActionBar({required this.listing});
  final Listing listing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => AuthGuard.run(ref, context,
                    () => ContactAgentSheet.show(context, listing.id)),
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text('Contact'),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              flex: 2,
              child: FilledButton.icon(
                onPressed: () => AuthGuard.run(ref, context,
                    () => ScheduleTourSheet.show(context, listing.id)),
                icon: const Icon(Icons.event_available_outlined),
                label: const Text('Schedule a tour'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailLoading extends StatelessWidget {
  const _DetailLoading();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(expandedHeight: 280, pinned: true),
        SliverPadding(
          padding: AppSpacing.pageAll,
          sliver: SliverList.list(
            children: const [
              ShimmerBox(width: 160, height: 28),
              SizedBox(height: AppSpacing.md),
              ShimmerBox(height: 18),
              SizedBox(height: AppSpacing.sm),
              ShimmerBox(width: 220, height: 18),
              SizedBox(height: AppSpacing.xl),
              ShimmerBox(height: 120),
            ],
          ),
        ),
      ],
    );
  }
}
