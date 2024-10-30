import 'package:api_client/src/data/pagination.dart';
import 'package:api_client/src/data/responses/cities_response.dart';
import 'package:api_client/src/models/city.dart';
import 'package:test/test.dart';

void main() {
  group('CitiesResponse', () {
    test('supports value comparisons', () {
      expect(
        const CitiesResponse(
          cities: [
            City(
              id: 1,
              name: 'Test City',
              localName: 'Local Test City',
              countryId: 1,
            ),
          ],
          pagination: Pagination(
            currentPage: 1,
            lastPage: 10,
            perPage: 20,
            total: 200,
          ),
        ),
        const CitiesResponse(
          cities: [
            City(
              id: 1,
              name: 'Test City',
              localName: 'Local Test City',
              countryId: 1,
            ),
          ],
          pagination: Pagination(
            currentPage: 1,
            lastPage: 10,
            perPage: 20,
            total: 200,
          ),
        ),
      );
    });

    test('can be serialized to JSON', () {
      const citiesResponse = CitiesResponse(
        cities: [
          City(
            id: 1,
            name: 'Test City',
            localName: 'Local Test City',
            countryId: 1,
          ),
        ],
        pagination: Pagination(
          currentPage: 1,
          lastPage: 10,
          perPage: 20,
          total: 200,
        ),
      );
      expect(
        citiesResponse.toJson(),
        {
          'items': [
            {
              'id': 1,
              'name': 'Test City',
              'local_name': 'Local Test City',
              'country_id': 1,
              'country': null,
              'lat': null,
              'lng': null,
            },
          ],
          'pagination': {
            'current_page': 1,
            'last_page': 10,
            'per_page': 20,
            'total': 200,
          },
        },
      );
    });

    test('can be deserialized from JSON', () {
      final json = {
        'items': [
          {
            'id': 1,
            'name': 'Test City',
            'local_name': 'Local Test City',
            'country_id': 1,
            'country': null,
            'lat': null,
            'lng': null,
          },
        ],
        'pagination': {
          'current_page': 1,
          'last_page': 10,
          'per_page': 20,
          'total': 200,
        },
      };
      expect(
        CitiesResponse.fromJson(json),
        const CitiesResponse(
          cities: [
            City(
              id: 1,
              name: 'Test City',
              localName: 'Local Test City',
              countryId: 1,
            ),
          ],
          pagination: Pagination(
            currentPage: 1,
            lastPage: 10,
            perPage: 20,
            total: 200,
          ),
        ),
      );
    });
  });
}
