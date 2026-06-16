import 'package:dwellio/data/models/search_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchFilters.toQuery', () {
    test('always includes dealType and sort, omits unset values', () {
      const filters = SearchFilters(dealType: 'rent');
      final query = filters.toQuery();

      expect(query['dealType'], 'rent');
      expect(query['sort'], 'newest');
      expect(query.containsKey('minPrice'), isFalse);
      expect(query.containsKey('q'), isFalse);
      expect(query.containsKey('beds'), isFalse);
    });

    test('maps every active content filter to a query param', () {
      const filters = SearchFilters(
        dealType: 'buy',
        q: 'Austin',
        minPrice: 100000,
        maxPrice: 500000,
        beds: 2,
        baths: 1,
        type: 'house',
        minArea: 80,
        amenities: ['pool', 'gym'],
        sort: 'price_asc',
      );

      final query = filters.toQuery();

      expect(query['q'], 'Austin');
      expect(query['minPrice'], 100000);
      expect(query['maxPrice'], 500000);
      expect(query['beds'], 2);
      expect(query['baths'], 1);
      expect(query['type'], 'house');
      expect(query['minArea'], 80);
      expect(query['amenities'], 'pool,gym'); // comma-joined
      expect(query['sort'], 'price_asc');
    });

    test('includes map bounds only when all four corners are present', () {
      const partial = SearchFilters(swLat: 1, swLng: 2); // incomplete
      expect(partial.hasBounds, isFalse);
      expect(partial.toQuery().containsKey('swLat'), isFalse);

      const full = SearchFilters(
        swLat: 30.1,
        swLng: -97.8,
        neLat: 30.4,
        neLng: -97.6,
      );
      final query = full.toQuery();
      expect(full.hasBounds, isTrue);
      expect(query['swLat'], 30.1);
      expect(query['neLng'], -97.6);
    });

    test('activeCount ignores dealType, sort and bounds', () {
      const filters = SearchFilters(
        dealType: 'rent',
        sort: 'price_desc',
        beds: 2,
        amenities: ['pool'],
        swLat: 1,
        swLng: 2,
        neLat: 3,
        neLng: 4,
      );
      // Only beds + amenities count.
      expect(filters.activeCount, 2);
    });

    test('clearBounds removes bounds but preserves other filters', () {
      const filters = SearchFilters(
        dealType: 'buy',
        beds: 3,
        swLat: 1,
        swLng: 2,
        neLat: 3,
        neLng: 4,
      );
      final cleared = filters.clearBounds();
      expect(cleared.hasBounds, isFalse);
      expect(cleared.beds, 3);
      expect(cleared.dealType, 'buy');
    });

    test('round-trips through JSON (used to persist saved searches)', () {
      const filters = SearchFilters(
        dealType: 'rent',
        beds: 2,
        maxPrice: 3000,
        amenities: ['pet_friendly'],
      );
      final restored = SearchFilters.fromJson(filters.toJson());
      expect(restored, filters);
    });
  });
}
