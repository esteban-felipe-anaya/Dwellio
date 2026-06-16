import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dwellio/core/network/api_exception.dart';
import 'package:dwellio/data/api/dwellio_api.dart';
import 'package:dwellio/data/models/search_filters.dart';
import 'package:dwellio/data/repositories/listing_repository.dart';
import 'package:flutter_test/flutter_test.dart';

/// A minimal Dio adapter that records the last request and returns a canned
/// response. Lets us test the repository against a *mocked Dio* with no server.
class _MockAdapter implements HttpClientAdapter {
  _MockAdapter({required this.statusCode, required this.body});

  int statusCode;
  String body;
  RequestOptions? lastRequest;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    return ResponseBody.fromString(
      body,
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

ListingRepository _repoWith(_MockAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test.local'))
    ..httpClientAdapter = adapter;
  return ListingRepository(DwellioApi(dio));
}

const _listingJson = {
  'id': 'lst_1',
  'title': 'Test Home',
  'dealType': 'rent',
  'price': 1850,
  'currency': 'USD',
  'propertyType': 'apartment',
  'beds': 2,
  'baths': 2,
  'areaSqm': 86,
  'parking': 1,
  'address': 'Av. Reforma 120, CDMX',
  'lat': 19.4270,
  'lng': -99.1677,
  'amenities': ['gym', 'pool'],
  'photos': ['https://example.com/a.jpg'],
  'agentId': 'agt_07',
  'description': 'Bright corner unit.',
  'listedAt': '2026-06-01T09:00:00Z',
};

void main() {
  group('ListingRepository.search', () {
    test('sends mapped query params and parses the listing list', () async {
      final adapter =
          _MockAdapter(statusCode: 200, body: jsonEncode([_listingJson]));
      final repo = _repoWith(adapter);

      const filters = SearchFilters(
        dealType: 'rent',
        beds: 2,
        maxPrice: 3000,
        amenities: ['gym', 'pool'],
      );
      final result = await repo.search(filters, page: 1, limit: 20);

      // Parsing
      expect(result, hasLength(1));
      expect(result.first.id, 'lst_1');
      expect(result.first.isRental, isTrue);
      expect(result.first.amenities, contains('pool'));

      // Query mapping reached Dio correctly.
      final qp = adapter.lastRequest!.queryParameters;
      expect(adapter.lastRequest!.path, '/listings');
      expect(qp['dealType'], 'rent');
      expect(qp['beds'], 2);
      expect(qp['maxPrice'], 3000);
      expect(qp['amenities'], 'gym,pool');
      expect(qp['_page'], 1);
      expect(qp['_limit'], 20);
    });

    test('translates a server error into a typed ApiException', () async {
      final adapter = _MockAdapter(
          statusCode: 500, body: jsonEncode({'message': 'boom'}));
      final repo = _repoWith(adapter);

      expect(
        () => repo.search(const SearchFilters()),
        throwsA(isA<ApiException>()
            .having((e) => e.statusCode, 'statusCode', 500)),
      );
    });
  });
}
