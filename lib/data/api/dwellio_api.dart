import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/agent.dart';
import '../models/app_notification.dart';
import '../models/inquiry.dart';
import '../models/listing.dart';
import '../models/reference.dart';
import '../models/saved_search.dart';
import '../models/tour.dart';
import '../models/user.dart';

part 'dwellio_api.g.dart';

/// Typed Retrofit client for the Dwellio mock REST API.
@RestApi()
abstract class DwellioApi {
  factory DwellioApi(Dio dio, {String? baseUrl}) = _DwellioApi;

  // --- Auth ---
  @POST('/auth/login')
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  @POST('/auth/register')
  Future<AuthResponse> register(@Body() Map<String, dynamic> body);

  @GET('/auth/me')
  Future<MeResponse> me();

  // --- Reference data ---
  @GET('/property-types')
  Future<List<PropertyType>> propertyTypes();

  @GET('/amenities')
  Future<List<Amenity>> amenities();

  // --- Listings ---
  @GET('/listings')
  Future<List<Listing>> listings(@Queries() Map<String, dynamic> queries);

  @GET('/listings/{id}')
  Future<Listing> listing(@Path('id') String id);

  @GET('/listings/{id}/similar')
  Future<List<Listing>> similarListings(@Path('id') String id);

  @POST('/listings')
  Future<Listing> createListing(@Body() Map<String, dynamic> body);

  // --- Agents ---
  @GET('/agents/{id}')
  Future<Agent> agent(@Path('id') String id);

  // --- Favorites (server stores a flat list of listing ids) ---
  @GET('/favorites')
  Future<List<String>> favorites();

  @POST('/favorites')
  Future<void> addFavorite(@Body() Map<String, dynamic> body);

  @DELETE('/favorites/{listingId}')
  Future<void> removeFavorite(@Path('listingId') String listingId);

  // --- Saved searches ---
  @GET('/saved-searches')
  Future<List<SavedSearch>> savedSearches();

  @POST('/saved-searches')
  Future<SavedSearch> createSavedSearch(@Body() Map<String, dynamic> body);

  // --- Tours & inquiries ---
  @POST('/tours')
  Future<Tour> scheduleTour(@Body() Map<String, dynamic> body);

  @GET('/inquiries')
  Future<List<Inquiry>> inquiries();

  @POST('/inquiries')
  Future<Inquiry> createInquiry(@Body() Map<String, dynamic> body);

  // --- Notifications ---
  @GET('/notifications')
  Future<List<AppNotification>> notifications();
}
