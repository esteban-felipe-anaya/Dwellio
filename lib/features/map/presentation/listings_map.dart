import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/listing.dart';
import '../../search/application/search_controller.dart';

/// OpenStreetMap-backed listings map. Linked to the search controller:
///  • panning/zooming re-queries by viewport bounds,
///  • tapping a pin highlights it and the matching list card,
///  • selecting a card (elsewhere) animates the map to that pin,
///  • pins cluster at low zoom.
class ListingsMap extends ConsumerStatefulWidget {
  const ListingsMap({super.key});

  @override
  ConsumerState<ListingsMap> createState() => _ListingsMapState();
}

class _ListingsMapState extends ConsumerState<ListingsMap> {
  final MapController _map = MapController();

  static const _fallbackCenter = LatLng(30.2672, -97.7431); // Austin

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchControllerProvider);
    final listings = state.listings;
    final selectedId = state.selectedId;
    final scheme = Theme.of(context).colorScheme;

    // List → map link: recenter when a card is selected.
    ref.listen(searchControllerProvider.select((s) => s.selectedId),
        (prev, next) {
      if (next == null) return;
      final target = _findById(next);
      if (target != null) {
        _map.move(LatLng(target.lat, target.lng), _map.camera.zoom);
      }
    });

    final markers = [
      for (final l in listings)
        Marker(
          key: ValueKey(l.id),
          point: LatLng(l.lat, l.lng),
          width: 96,
          height: 40,
          alignment: Alignment.topCenter,
          child: _PricePin(listing: l, selected: l.id == selectedId),
        ),
    ];

    return Stack(
      children: [
        FlutterMap(
          mapController: _map,
          options: MapOptions(
            initialCenter: listings.isNotEmpty
                ? LatLng(listings.first.lat, listings.first.lng)
                : _fallbackCenter,
            initialZoom: 11,
            onPositionChanged: (camera, hasGesture) {
              if (!hasGesture) return;
              final b = camera.visibleBounds;
              ref
                  .read(searchControllerProvider.notifier)
                  .onMapBoundsChanged(b.south, b.west, b.north, b.east);
            },
            onTap: (_, _) =>
                ref.read(searchControllerProvider.notifier).select(null),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.dwellio.app',
              maxZoom: 19,
            ),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                maxClusterRadius: 48,
                size: const Size(44, 44),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50),
                markers: markers,
                markerChildBehavior: true,
                onMarkerTap: (marker) {
                  final id = (marker.key as ValueKey).value as String;
                  ref.read(searchControllerProvider.notifier).select(id);
                },
                builder: (context, clusterMarkers) => Container(
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${clusterMarkers.length}',
                    style: TextStyle(
                      color: scheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // OSM attribution (required by the tile usage policy).
        Positioned(
          bottom: 0,
          right: 0,
          child: ColoredBox(
            color: scheme.surface.withValues(alpha: 0.75),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              child: Text('© OpenStreetMap', style: TextStyle(fontSize: 10)),
            ),
          ),
        ),
        if (state.results.isLoading)
          const Positioned(
            top: AppSpacing.md,
            right: AppSpacing.md,
            child: _MapBadge(child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )),
          ),
      ],
    );
  }

  Listing? _findById(String id) {
    for (final l in ref.read(searchControllerProvider).listings) {
      if (l.id == id) return l;
    }
    return null;
  }
}

class _MapBadge extends StatelessWidget {
  const _MapBadge({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: const EdgeInsets.all(AppSpacing.sm), child: child),
    );
  }
}

class _PricePin extends StatelessWidget {
  const _PricePin({required this.listing, required this.selected});
  final Listing listing;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = selected ? scheme.primary : scheme.surface;
    final fg = selected ? scheme.onPrimary : scheme.onSurface;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: bg,
          elevation: selected ? 6 : 2,
          borderRadius: AppRadii.chipRadius,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              Formatters.price(listing.price,
                  currency: listing.currency, rental: false),
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ),
        Icon(Icons.arrow_drop_down, color: bg, size: 18),
      ],
    );
  }
}
