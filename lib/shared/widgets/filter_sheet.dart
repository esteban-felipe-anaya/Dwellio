import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/design_tokens.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/search_filters.dart';
import '../../data/repositories/listing_repository.dart';

/// M3 modal bottom sheet for refining search criteria. Returns the new
/// [SearchFilters] on apply, or null if dismissed.
class FilterSheet extends ConsumerStatefulWidget {
  const FilterSheet({super.key, required this.initial});

  final SearchFilters initial;

  static Future<SearchFilters?> show(
    BuildContext context,
    SearchFilters initial,
  ) {
    return showModalBottomSheet<SearchFilters>(
      context: context,
      isScrollControlled: true,
      builder: (_) => FilterSheet(initial: initial),
    );
  }

  @override
  ConsumerState<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends ConsumerState<FilterSheet> {
  late SearchFilters _draft;

  @override
  void initState() {
    super.initState();
    _draft = widget.initial;
  }

  double get _priceCeiling => _draft.dealType == 'rent' ? 10000 : 2000000;
  double get _priceStep => _draft.dealType == 'rent' ? 100 : 25000;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaH = MediaQuery.of(context).size.height;
    final priceMax = (_draft.maxPrice ?? _priceCeiling).toDouble();
    final priceMin = (_draft.minPrice ?? 0).toDouble();

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: mediaH * 0.9),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
            child: Row(
              children: [
                Text('Filters', style: theme.textTheme.titleLarge),
                const Spacer(),
                TextButton(
                  onPressed: () =>
                      setState(() => _draft = _draft.cleared()),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView(
              padding: AppSpacing.pageAll,
              children: [
                // Deal type
                const _SectionLabel('I want to'),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'buy', label: Text('Buy')),
                    ButtonSegment(value: 'rent', label: Text('Rent')),
                  ],
                  selected: {_draft.dealType},
                  onSelectionChanged: (s) =>
                      setState(() => _draft = _draft.copyWith(dealType: s.first)),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Price range
                const _SectionLabel('Price range'),
                Text(
                  '${Formatters.currency(priceMin)} – '
                  '${priceMax >= _priceCeiling ? "Any" : Formatters.currency(priceMax)}',
                  style: theme.textTheme.bodyMedium,
                ),
                RangeSlider(
                  min: 0,
                  max: _priceCeiling,
                  divisions: (_priceCeiling / _priceStep).round(),
                  labels: RangeLabels(
                    Formatters.currency(priceMin),
                    Formatters.currency(priceMax),
                  ),
                  values: RangeValues(
                    priceMin.clamp(0, _priceCeiling),
                    priceMax.clamp(0, _priceCeiling),
                  ),
                  onChanged: (v) => setState(() {
                    _draft = _draft.copyWith(
                      minPrice: v.start == 0 ? null : v.start,
                      maxPrice: v.end >= _priceCeiling ? null : v.end,
                    );
                  }),
                ),
                const SizedBox(height: AppSpacing.md),

                // Beds & baths
                const _SectionLabel('Bedrooms'),
                _CountChips(
                  value: _draft.beds,
                  onChanged: (v) =>
                      setState(() => _draft = _rebuildWithBeds(v)),
                ),
                const SizedBox(height: AppSpacing.lg),
                const _SectionLabel('Bathrooms'),
                _CountChips(
                  value: _draft.baths,
                  onChanged: (v) =>
                      setState(() => _draft = _rebuildWithBaths(v)),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Property type
                const _SectionLabel('Property type'),
                _PropertyTypePicker(
                  selected: _draft.type,
                  onChanged: (t) =>
                      setState(() => _draft = _rebuildWithType(t)),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Min area
                const _SectionLabel('Minimum area'),
                Text(
                  _draft.minArea == null
                      ? 'Any'
                      : Formatters.area(_draft.minArea!),
                  style: theme.textTheme.bodyMedium,
                ),
                Slider(
                  min: 0,
                  max: 400,
                  divisions: 40,
                  label: '${(_draft.minArea ?? 0).round()} m²',
                  value: (_draft.minArea ?? 0).toDouble().clamp(0, 400),
                  onChanged: (v) => setState(() => _draft = _draft.copyWith(
                        minArea: v == 0 ? null : v,
                      )),
                ),
                const SizedBox(height: AppSpacing.md),

                // Amenities
                const _SectionLabel('Amenities'),
                _AmenityPicker(
                  selected: _draft.amenities,
                  onChanged: (list) =>
                      setState(() => _draft = _draft.copyWith(amenities: list)),
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: AppSpacing.pageAll,
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(_draft),
                  child: const Text('Show results'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Beds/baths/type can be cleared back to "Any" — rebuild to unset.
  SearchFilters _rebuildWithBeds(int? v) => SearchFilters(
        dealType: _draft.dealType,
        q: _draft.q,
        minPrice: _draft.minPrice,
        maxPrice: _draft.maxPrice,
        beds: v,
        baths: _draft.baths,
        type: _draft.type,
        minArea: _draft.minArea,
        amenities: _draft.amenities,
        sort: _draft.sort,
      );

  SearchFilters _rebuildWithBaths(int? v) => SearchFilters(
        dealType: _draft.dealType,
        q: _draft.q,
        minPrice: _draft.minPrice,
        maxPrice: _draft.maxPrice,
        beds: _draft.beds,
        baths: v,
        type: _draft.type,
        minArea: _draft.minArea,
        amenities: _draft.amenities,
        sort: _draft.sort,
      );

  SearchFilters _rebuildWithType(String? t) => SearchFilters(
        dealType: _draft.dealType,
        q: _draft.q,
        minPrice: _draft.minPrice,
        maxPrice: _draft.maxPrice,
        beds: _draft.beds,
        baths: _draft.baths,
        type: t,
        minArea: _draft.minArea,
        amenities: _draft.amenities,
        sort: _draft.sort,
      );
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w600)),
      );
}

class _CountChips extends StatelessWidget {
  const _CountChips({required this.value, required this.onChanged});
  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      children: [
        for (final option in <int?>[null, 1, 2, 3, 4, 5])
          FilterChip(
            label: Text(option == null ? 'Any' : '$option+'),
            selected: value == option,
            onSelected: (_) => onChanged(option),
          ),
      ],
    );
  }
}

class _PropertyTypePicker extends ConsumerWidget {
  const _PropertyTypePicker({required this.selected, required this.onChanged});
  final String? selected;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final types = ref.watch(propertyTypesProvider);
    return types.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: LinearProgressIndicator(),
      ),
      error: (_, _) => const Text('Could not load property types'),
      data: (list) => Wrap(
        spacing: AppSpacing.sm,
        children: [
          for (final t in list)
            FilterChip(
              avatar: Icon(AppIcons.resolve(t.icon), size: AppSizes.iconChip),
              label: Text(t.name),
              selected: selected == t.id,
              onSelected: (sel) => onChanged(sel ? t.id : null),
            ),
        ],
      ),
    );
  }
}

class _AmenityPicker extends ConsumerWidget {
  const _AmenityPicker({required this.selected, required this.onChanged});
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amenities = ref.watch(amenitiesProvider);
    return amenities.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: LinearProgressIndicator(),
      ),
      error: (_, _) => const Text('Could not load amenities'),
      data: (list) => Wrap(
        spacing: AppSpacing.sm,
        children: [
          for (final a in list)
            FilterChip(
              avatar: Icon(AppIcons.resolve(a.icon), size: AppSizes.iconChip),
              label: Text(a.name),
              selected: selected.contains(a.id),
              onSelected: (sel) {
                final next = [...selected];
                sel ? next.add(a.id) : next.remove(a.id);
                onChanged(next);
              },
            ),
        ],
      ),
    );
  }
}
