import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../data/repositories/listing_repository.dart';
import '../../../shared/widgets/listing_card.dart';
import '../../../shared/widgets/state_views.dart';
import '../../auth/application/auth_controller.dart';
import '../application/favorites_controller.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  int _columns(double w) => (w / 340).floor().clamp(1, 4);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authed = ref.watch(isAuthenticatedProvider);
    final favorites = ref.watch(favoritesControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Saved homes')),
      body: !authed
          ? EmptyView(
              icon: Icons.favorite_outline,
              title: 'Sign in to see your favorites',
              message: 'Save homes you love and find them here.',
              action: FilledButton(
                onPressed: () => context.pushNamed(Routes.login),
                child: const Text('Sign in'),
              ),
            )
          : favorites.when(
              loading: () => const ListingGridSkeleton(crossAxisCount: 2),
              error: (e, _) => ErrorView(
                message: e.toString(),
                onRetry: () =>
                    ref.invalidate(favoritesControllerProvider),
              ),
              data: (ids) {
                if (ids.isEmpty) {
                  return EmptyView(
                    icon: Icons.favorite_outline,
                    title: 'No saved homes yet',
                    message: 'Tap the heart on any listing to save it.',
                    action: FilledButton(
                      onPressed: () => context.goNamed(Routes.search),
                      child: const Text('Browse homes'),
                    ),
                  );
                }
                final idList = ids.toList();
                return LayoutBuilder(
                  builder: (context, constraints) => GridView.builder(
                    padding: AppSpacing.pageAll,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _columns(constraints.maxWidth),
                      mainAxisExtent: 300,
                      crossAxisSpacing: AppSpacing.lg,
                      mainAxisSpacing: AppSpacing.lg,
                    ),
                    itemCount: idList.length,
                    itemBuilder: (context, i) =>
                        _FavoriteTile(listingId: idList[i]),
                  ),
                );
              },
            ),
    );
  }
}

class _FavoriteTile extends ConsumerWidget {
  const _FavoriteTile({required this.listingId});
  final String listingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listing = ref.watch(listingProvider(listingId));
    return listing.when(
      loading: () => const ListingCardSkeleton(),
      error: (_, _) => const SizedBox.shrink(),
      data: (l) => ListingCard(
        listing: l,
        onTap: () =>
            context.pushNamed(Routes.listing, pathParameters: {'id': l.id}),
      ),
    );
  }
}
