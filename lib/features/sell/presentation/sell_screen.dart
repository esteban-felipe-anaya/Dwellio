import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_network_image.dart';
import '../application/sell_controller.dart';

/// Sample real-estate stock photos the user can attach (keeps the flow
/// cross-platform without a native file picker). Unsplash CDN, free to hotlink.
String _stock(String id) =>
    'https://images.unsplash.com/photo-$id?auto=format&fit=crop&w=800&q=60';

final _stockPhotos = [
  _stock('1568605114967-8130f3a36994'),
  _stock('1600596542815-ffad4c1539a9'),
  _stock('1600585154340-be6161a56a0c'),
  _stock('1564013799919-ab600027ffc6'),
  _stock('1502005229762-cf1b2da7c5d6'),
  _stock('1583608205776-bfd35f0d9f83'),
];

class SellScreen extends ConsumerStatefulWidget {
  const SellScreen({super.key});

  @override
  ConsumerState<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends ConsumerState<SellScreen> {
  final _title = TextEditingController();
  final _address = TextEditingController();
  final _area = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();
  bool _publishing = false;

  @override
  void initState() {
    super.initState();
    // Start each visit from a clean draft.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sellControllerProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _title.dispose();
    _address.dispose();
    _area.dispose();
    _price.dispose();
    _description.dispose();
    super.dispose();
  }

  SellController get _ctrl => ref.read(sellControllerProvider.notifier);

  Future<void> _publish() async {
    setState(() => _publishing = true);
    try {
      final listing = await _ctrl.publish();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your listing is now live!')),
      );
      context.pushReplacementNamed(Routes.listing,
          pathParameters: {'id': listing.id});
    } catch (_) {
      if (mounted) {
        setState(() => _publishing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Couldn't publish your listing")),
        );
      }
    }
  }

  void _onContinue(ListingDraft draft) {
    // Validate the current step before advancing.
    switch (draft.step) {
      case 0:
        if (!draft.detailsValid) {
          _toast('Add a title, address and area to continue.');
          return;
        }
      case 1:
        if (!draft.photosValid) {
          _toast('Add at least one photo.');
          return;
        }
      case 2:
        if (!draft.priceValid) {
          _toast('Enter a price.');
          return;
        }
      case 3:
        _publish();
        return;
    }
    _ctrl.nextStep();
  }

  void _toast(String msg) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(msg)));

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(sellControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('List a property')),
      body: Stepper(
        currentStep: draft.step,
        onStepContinue: () => _onContinue(draft),
        onStepCancel: draft.step == 0 ? null : _ctrl.prevStep,
        onStepTapped: (s) => _ctrl.goToStep(s),
        controlsBuilder: (context, details) => Padding(
          padding: const EdgeInsets.only(top: AppSpacing.lg),
          child: Row(
            children: [
              FilledButton(
                onPressed: _publishing ? null : details.onStepContinue,
                child: _publishing && draft.step == 3
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : Text(draft.step == 3 ? 'Publish' : 'Continue'),
              ),
              if (draft.step > 0) ...[
                const SizedBox(width: AppSpacing.sm),
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Back'),
                ),
              ],
            ],
          ),
        ),
        steps: [
          Step(
            title: const Text('Details'),
            isActive: draft.step >= 0,
            content: _DetailsStep(
              draft: draft,
              title: _title,
              address: _address,
              area: _area,
              onChanged: _ctrl.update,
            ),
          ),
          Step(
            title: const Text('Photos'),
            isActive: draft.step >= 1,
            content: _PhotosStep(draft: draft, onChanged: _ctrl.update),
          ),
          Step(
            title: const Text('Price'),
            isActive: draft.step >= 2,
            content: _PriceStep(
              draft: draft,
              price: _price,
              description: _description,
              onChanged: _ctrl.update,
            ),
          ),
          Step(
            title: const Text('Review'),
            isActive: draft.step >= 3,
            content: _ReviewStep(draft: draft),
          ),
        ],
      ),
    );
  }
}

typedef DraftUpdater = void Function(ListingDraft Function(ListingDraft));

class _DetailsStep extends StatelessWidget {
  const _DetailsStep({
    required this.draft,
    required this.title,
    required this.address,
    required this.area,
    required this.onChanged,
  });

  final ListingDraft draft;
  final TextEditingController title;
  final TextEditingController address;
  final TextEditingController area;
  final DraftUpdater onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'buy', label: Text('For sale')),
            ButtonSegment(value: 'rent', label: Text('For rent')),
          ],
          selected: {draft.dealType},
          onSelectionChanged: (s) =>
              onChanged((d) => d.copyWith(dealType: s.first)),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: title,
          decoration: const InputDecoration(labelText: 'Title'),
          onChanged: (v) => onChanged((d) => d.copyWith(title: v)),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: address,
          decoration: const InputDecoration(labelText: 'Address'),
          onChanged: (v) => onChanged((d) => d.copyWith(address: v)),
        ),
        const SizedBox(height: AppSpacing.md),
        DropdownButtonFormField<String>(
          initialValue: draft.city,
          decoration: const InputDecoration(labelText: 'City'),
          items: const [
            DropdownMenuItem(value: 'Austin', child: Text('Austin')),
            DropdownMenuItem(value: 'CDMX', child: Text('CDMX')),
            DropdownMenuItem(value: 'Lisbon', child: Text('Lisbon')),
          ],
          onChanged: (v) =>
              onChanged((d) => d.copyWith(city: v, lat: _cityLat(v), lng: _cityLng(v))),
        ),
        const SizedBox(height: AppSpacing.md),
        DropdownButtonFormField<String>(
          initialValue: draft.propertyType,
          decoration: const InputDecoration(labelText: 'Property type'),
          items: const [
            DropdownMenuItem(value: 'apartment', child: Text('Apartment')),
            DropdownMenuItem(value: 'house', child: Text('House')),
            DropdownMenuItem(value: 'condo', child: Text('Condo')),
            DropdownMenuItem(value: 'townhouse', child: Text('Townhouse')),
            DropdownMenuItem(value: 'studio', child: Text('Studio')),
            DropdownMenuItem(value: 'villa', child: Text('Villa')),
          ],
          onChanged: (v) =>
              onChanged((d) => d.copyWith(propertyType: v ?? 'apartment')),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _Stepper(
                label: 'Beds',
                value: draft.beds,
                onChanged: (v) => onChanged((d) => d.copyWith(beds: v)),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _Stepper(
                label: 'Baths',
                value: draft.baths,
                onChanged: (v) => onChanged((d) => d.copyWith(baths: v)),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: area,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Area (m²)'),
                onChanged: (v) => onChanged(
                    (d) => d.copyWith(areaSqm: num.tryParse(v) ?? 0)),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _Stepper(
                label: 'Parking',
                value: draft.parking,
                onChanged: (v) => onChanged((d) => d.copyWith(parking: v)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static double _cityLat(String? c) =>
      {'Austin': 30.2672, 'CDMX': 19.4326, 'Lisbon': 38.7223}[c] ?? 30.2672;
  static double _cityLng(String? c) =>
      {'Austin': -97.7431, 'CDMX': -99.1332, 'Lisbon': -9.1393}[c] ?? -97.7431;
}

class _PhotosStep extends StatelessWidget {
  const _PhotosStep({required this.draft, required this.onChanged});
  final ListingDraft draft;
  final DraftUpdater onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tap to add photos to your listing',
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: AppSpacing.md),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          children: [
            for (final url in _stockPhotos)
              _SelectablePhoto(
                url: url,
                selected: draft.photos.contains(url),
                onTap: () {
                  final next = [...draft.photos];
                  next.contains(url) ? next.remove(url) : next.add(url);
                  onChanged((d) => d.copyWith(photos: next));
                },
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text('${draft.photos.length} selected',
            style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _SelectablePhoto extends StatelessWidget {
  const _SelectablePhoto(
      {required this.url, required this.selected, required this.onTap});
  final String url;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.md),
            child: AppNetworkImage(url: url),
          ),
          if (selected)
            Container(
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(AppRadii.md),
                border: Border.all(color: scheme.primary, width: 2),
              ),
              child: Icon(Icons.check_circle, color: scheme.onPrimary),
            ),
        ],
      ),
    );
  }
}

class _PriceStep extends StatelessWidget {
  const _PriceStep({
    required this.draft,
    required this.price,
    required this.description,
    required this.onChanged,
  });

  final ListingDraft draft;
  final TextEditingController price;
  final TextEditingController description;
  final DraftUpdater onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: price,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: draft.dealType == 'rent'
                ? 'Monthly rent (USD)'
                : 'Price (USD)',
            prefixText: '\$ ',
          ),
          onChanged: (v) =>
              onChanged((d) => d.copyWith(price: num.tryParse(v) ?? 0)),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: description,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: 'Description',
            alignLabelWithHint: true,
          ),
          onChanged: (v) => onChanged((d) => d.copyWith(description: v)),
        ),
      ],
    );
  }
}

class _ReviewStep extends StatelessWidget {
  const _ReviewStep({required this.draft});
  final ListingDraft draft;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (draft.photos.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.md),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: AppNetworkImage(url: draft.photos.first),
            ),
          ),
        const SizedBox(height: AppSpacing.md),
        Text(draft.title.isEmpty ? 'Untitled listing' : draft.title,
            style: Theme.of(context).textTheme.titleLarge),
        Text(
          Formatters.price(draft.price, rental: draft.dealType == 'rent'),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text('${draft.beds} bd · ${draft.baths} ba · '
            '${Formatters.area(draft.areaSqm)} · ${draft.city}'),
        const SizedBox(height: AppSpacing.sm),
        Text(draft.address),
        const SizedBox(height: AppSpacing.md),
        Text(draft.description),
      ],
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper(
      {required this.label, required this.value, required this.onChanged});
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(labelText: label),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: value > 0 ? () => onChanged(value - 1) : null,
            icon: const Icon(Icons.remove),
          ),
          Text('$value'),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () => onChanged(value + 1),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
