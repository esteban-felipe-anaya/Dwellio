import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/theme/design_tokens.dart';

/// A small, non-interactive location map for the detail screen.
class MiniMap extends StatelessWidget {
  const MiniMap({super.key, required this.lat, required this.lng});

  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final point = LatLng(lat, lng);
    return ClipRRect(
      borderRadius: AppRadii.cardRadius,
      child: SizedBox(
        height: 180,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: point,
            initialZoom: 14,
            interactionOptions:
                const InteractionOptions(flags: InteractiveFlag.none),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.dwellio.app',
            ),
            MarkerLayer(markers: [
              Marker(
                point: point,
                width: 44,
                height: 44,
                child: Icon(Icons.location_pin,
                    color: scheme.error, size: 44),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
