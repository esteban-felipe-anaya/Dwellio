import 'package:flutter/material.dart';

/// Maps the icon-name strings returned by the API (amenities, property types)
/// to const [IconData]. A lookup map keeps icons tree-shakeable, unlike
/// constructing IconData from dynamic code points.
class AppIcons {
  const AppIcons._();

  static const _map = <String, IconData>{
    // Property types
    'apartment': Icons.apartment,
    'house': Icons.house_outlined,
    'domain': Icons.domain,
    'holiday_village': Icons.holiday_village_outlined,
    'single_bed': Icons.single_bed_outlined,
    'villa': Icons.villa_outlined,
    'landscape': Icons.landscape_outlined,
    'home': Icons.home_outlined,
    // Amenities
    'fitness_center': Icons.fitness_center,
    'pool': Icons.pool,
    'pets': Icons.pets,
    'elevator': Icons.elevator_outlined,
    'local_parking': Icons.local_parking,
    'balcony': Icons.balcony_outlined,
    'yard': Icons.yard_outlined,
    'ac_unit': Icons.ac_unit,
    'security': Icons.security,
    'chair': Icons.chair_outlined,
    'wifi': Icons.wifi,
    'local_laundry_service': Icons.local_laundry_service_outlined,
    'check': Icons.check_circle_outline,
  };

  static IconData resolve(String? name) =>
      _map[name] ?? Icons.check_circle_outline;
}
