import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../data/repositories/listing_repository.dart';

/// Grid of amenity chips, resolving ids to friendly names + icons via the
/// amenities reference data.
class AmenitiesGrid extends ConsumerWidget {
  const AmenitiesGrid({super.key, required this.amenityIds});

  final List<String> amenityIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (amenityIds.isEmpty) {
      return Text('No amenities listed',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant));
    }
    final amenities = ref.watch(amenitiesProvider);
    final names = {
      for (final a in amenities.value ?? const []) a.id: a,
    };

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        for (final id in amenityIds)
          Chip(
            avatar: Icon(AppIcons.resolve(names[id]?.icon),
                size: AppSizes.iconChip),
            label: Text(names[id]?.name ?? id),
          ),
      ],
    );
  }
}
