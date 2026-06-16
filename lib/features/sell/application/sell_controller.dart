import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/listing.dart';
import '../../../data/repositories/listing_repository.dart';
import '../../search/application/search_controller.dart';

part 'sell_controller.g.dart';

/// Working draft for the multi-step "List a property" flow.
class ListingDraft {
  const ListingDraft({
    this.step = 0,
    this.title = '',
    this.dealType = 'buy',
    this.propertyType = 'apartment',
    this.price = 0,
    this.beds = 1,
    this.baths = 1,
    this.areaSqm = 0,
    this.parking = 0,
    this.address = '',
    this.city = 'Austin',
    this.lat = 30.2672,
    this.lng = -97.7431,
    this.description = '',
    this.amenities = const [],
    this.photos = const [],
  });

  final int step;
  final String title;
  final String dealType;
  final String propertyType;
  final num price;
  final int beds;
  final int baths;
  final num areaSqm;
  final int parking;
  final String address;
  final String city;
  final double lat;
  final double lng;
  final String description;
  final List<String> amenities;
  final List<String> photos;

  bool get detailsValid =>
      title.trim().isNotEmpty && address.trim().isNotEmpty && areaSqm > 0;
  bool get priceValid => price > 0;
  bool get photosValid => photos.isNotEmpty;

  ListingDraft copyWith({
    int? step,
    String? title,
    String? dealType,
    String? propertyType,
    num? price,
    int? beds,
    int? baths,
    num? areaSqm,
    int? parking,
    String? address,
    String? city,
    double? lat,
    double? lng,
    String? description,
    List<String>? amenities,
    List<String>? photos,
  }) =>
      ListingDraft(
        step: step ?? this.step,
        title: title ?? this.title,
        dealType: dealType ?? this.dealType,
        propertyType: propertyType ?? this.propertyType,
        price: price ?? this.price,
        beds: beds ?? this.beds,
        baths: baths ?? this.baths,
        areaSqm: areaSqm ?? this.areaSqm,
        parking: parking ?? this.parking,
        address: address ?? this.address,
        city: city ?? this.city,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        description: description ?? this.description,
        amenities: amenities ?? this.amenities,
        photos: photos ?? this.photos,
      );

  Map<String, dynamic> toBody() => {
        'title': title.trim(),
        'dealType': dealType,
        'price': price,
        'currency': 'USD',
        'propertyType': propertyType,
        'beds': beds,
        'baths': baths,
        'areaSqm': areaSqm,
        'parking': parking,
        'address': address.trim(),
        'city': city,
        'lat': lat,
        'lng': lng,
        'amenities': amenities,
        'photos': photos,
        'agentId': 'agt_01',
        'description': description.trim(),
      };
}

/// Drives the create-listing wizard and publishes to the API.
@riverpod
class SellController extends _$SellController {
  @override
  ListingDraft build() => const ListingDraft();

  void update(ListingDraft Function(ListingDraft) fn) => state = fn(state);

  void nextStep() => state = state.copyWith(step: (state.step + 1).clamp(0, 3));
  void prevStep() => state = state.copyWith(step: (state.step - 1).clamp(0, 3));
  void goToStep(int step) => state = state.copyWith(step: step.clamp(0, 3));
  void reset() => state = const ListingDraft();

  /// Publishes the draft. The new listing is appended to "My listings" and the
  /// search results are invalidated so it shows up there too.
  Future<Listing> publish() async {
    final listing =
        await ref.read(listingRepositoryProvider).create(state.toBody());
    ref.read(myListingsControllerProvider.notifier).add(listing);
    ref.invalidate(searchControllerProvider);
    reset();
    return listing;
  }
}

/// Listings created by the current user during this session ("My listings").
@Riverpod(keepAlive: true)
class MyListingsController extends _$MyListingsController {
  @override
  List<Listing> build() => [];

  void add(Listing listing) => state = [listing, ...state];
}
