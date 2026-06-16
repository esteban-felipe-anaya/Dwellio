import 'package:flutter/material.dart';

import '../../core/theme/design_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/listing.dart';

/// Compact bed / bath / area row shown on cards and the detail header.
class SpecChips extends StatelessWidget {
  const SpecChips({super.key, required this.listing, this.spacing = AppSpacing.md});

  final Listing listing;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: AppSpacing.xs,
      children: [
        if (listing.beds > 0)
          _Spec(icon: Icons.bed_outlined, label: '${listing.beds} bd'),
        if (listing.baths > 0)
          _Spec(icon: Icons.bathtub_outlined, label: '${listing.baths} ba'),
        _Spec(icon: Icons.square_foot, label: Formatters.area(listing.areaSqm)),
        if (listing.parking > 0)
          _Spec(icon: Icons.local_parking, label: '${listing.parking}'),
      ],
    );
  }
}

class _Spec extends StatelessWidget {
  const _Spec({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: AppSizes.iconChip, color: scheme.onSurfaceVariant),
        const SizedBox(width: AppSpacing.xs),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
