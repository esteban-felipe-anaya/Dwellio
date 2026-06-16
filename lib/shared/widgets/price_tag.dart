import 'package:flutter/material.dart';

import '../../core/theme/design_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/listing.dart';

/// The listing price, styled prominently, with a `/mo` suffix for rentals.
class PriceTag extends StatelessWidget {
  const PriceTag({super.key, required this.listing, this.style});

  final Listing listing;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      Formatters.price(listing.price,
          currency: listing.currency, rental: listing.isRental),
      style: style ??
          Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

/// Small "For Rent" / "For Sale" pill.
class DealTypeBadge extends StatelessWidget {
  const DealTypeBadge({super.key, required this.dealType});

  final String dealType;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final rental = dealType == 'rent';
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: rental ? scheme.tertiaryContainer : scheme.primaryContainer,
        borderRadius: AppRadii.chipRadius,
      ),
      child: Text(
        rental ? 'For Rent' : 'For Sale',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: rental
                  ? scheme.onTertiaryContainer
                  : scheme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
