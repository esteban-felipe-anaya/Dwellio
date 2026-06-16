import 'package:flutter/material.dart';

import '../../core/theme/design_tokens.dart';
import '../../data/models/listing.dart';
import 'app_network_image.dart';
import 'favorite_button.dart';
import 'price_tag.dart';
import 'spec_chips.dart';

/// The primary listing card used in search results, favorites, home rails and
/// "my listings". Tapping opens the detail screen.
class ListingCard extends StatelessWidget {
  const ListingCard({
    super.key,
    required this.listing,
    required this.onTap,
    this.highlighted = false,
  });

  final Listing listing;
  final VoidCallback onTap;

  /// When true (selected from the map) the card shows an accent outline.
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.cardRadius,
        side: highlighted
            ? BorderSide(color: scheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image flexes to fill the cell so the card never overflows its
            // grid extent / rail height regardless of width.
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppNetworkImage(url: listing.coverPhoto),
                  Positioned(
                    top: AppSpacing.sm,
                    left: AppSpacing.sm,
                    child: DealTypeBadge(dealType: listing.dealType),
                  ),
                  Positioned(
                    top: AppSpacing.xs,
                    right: AppSpacing.xs,
                    child: FavoriteButton(
                        listingId: listing.id, filledBackground: true),
                  ),
                  if (listing.featured)
                    Positioned(
                      bottom: AppSpacing.sm,
                      left: AppSpacing.sm,
                      child: _FeaturedTag(),
                    ),
                ],
              ),
            ),
            Padding(
              padding: AppSpacing.cardAll,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PriceTag(listing: listing),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    listing.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Icon(Icons.place_outlined,
                          size: AppSizes.iconChip,
                          color: scheme.onSurfaceVariant),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          listing.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SpecChips(listing: listing),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: scheme.inverseSurface.withValues(alpha: 0.9),
        borderRadius: AppRadii.chipRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, size: 14, color: scheme.tertiary),
          const SizedBox(width: AppSpacing.xs),
          Text('Featured',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: scheme.onInverseSurface,
                  )),
        ],
      ),
    );
  }
}

/// Horizontal variant used in home rails and "similar listings".
class ListingCardCompact extends StatelessWidget {
  const ListingCardCompact({
    super.key,
    required this.listing,
    required this.onTap,
    this.width = 260,
  });

  final Listing listing;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ListingCard(listing: listing, onTap: onTap),
    );
  }
}
