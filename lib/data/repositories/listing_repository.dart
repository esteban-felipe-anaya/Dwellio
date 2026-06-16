import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/guard.dart';
import '../../core/providers/core_providers.dart';
import '../api/dwellio_api.dart';
import '../models/agent.dart';
import '../models/listing.dart';
import '../models/reference.dart';
import '../models/search_filters.dart';

/// Domain access to listings, agents and reference data.
class ListingRepository {
  ListingRepository(this._api);

  final DwellioApi _api;

  Future<List<Listing>> search(SearchFilters filters, {int? page, int? limit}) {
    final query = filters.toQuery();
    if (page != null) query['_page'] = page;
    if (limit != null) query['_limit'] = limit;
    return guard(() => _api.listings(query));
  }

  Future<Listing> byId(String id) => guard(() => _api.listing(id));

  Future<List<Listing>> similar(String id) =>
      guard(() => _api.similarListings(id));

  Future<List<Listing>> featured() =>
      guard(() => _api.listings({'featured': 'true', '_limit': 10}));

  Future<Listing> create(Map<String, dynamic> body) =>
      guard(() => _api.createListing(body));

  Future<Agent> agent(String id) => guard(() => _api.agent(id));

  Future<List<PropertyType>> propertyTypes() =>
      guard(() => _api.propertyTypes());

  Future<List<Amenity>> amenities() => guard(() => _api.amenities());
}

final listingRepositoryProvider = Provider<ListingRepository>(
  (ref) => ListingRepository(ref.watch(dwellioApiProvider)),
);

/// Reference data is small and stable — cache it for the session.
final propertyTypesProvider = FutureProvider<List<PropertyType>>(
  (ref) => ref.watch(listingRepositoryProvider).propertyTypes(),
);

final amenitiesProvider = FutureProvider<List<Amenity>>(
  (ref) => ref.watch(listingRepositoryProvider).amenities(),
);

final agentProvider = FutureProvider.family<Agent, String>(
  (ref, id) => ref.watch(listingRepositoryProvider).agent(id),
);

final listingProvider = FutureProvider.family<Listing, String>(
  (ref, id) => ref.watch(listingRepositoryProvider).byId(id),
);

final similarListingsProvider = FutureProvider.family<List<Listing>, String>(
  (ref, id) => ref.watch(listingRepositoryProvider).similar(id),
);

final featuredListingsProvider = FutureProvider<List<Listing>>(
  (ref) => ref.watch(listingRepositoryProvider).featured(),
);
