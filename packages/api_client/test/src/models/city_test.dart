import 'package:api_client/src/models/city.dart';
import 'package:api_client/src/models/country.dart';
import 'package:test/test.dart';

void main() {
  group('City', () {
    test('supports value comparisons', () {
      expect(
        const City(
          id: 1,
          name: 'Test City',
          localName: 'Local Test City',
          countryId: 1,
        ),
        const City(
          id: 1,
          name: 'Test City',
          localName: 'Local Test City',
          countryId: 1,
        ),
      );
    });

    test('can be serialized to JSON', () {
      const city = City(
        id: 1,
        name: 'Test City',
        localName: 'Local Test City',
        countryId: 1,
      );
      expect(
        city.toJson(),
        {
          'id': 1,
          'name': 'Test City',
          'local_name': 'Local Test City',
          'country_id': 1,
          'country': null,
          'lat': null,
          'lng': null,
        },
      );
    });

    test('can be deserialized from JSON', () {
      final json = {
        'id': 1,
        'name': 'Test City',
        'local_name': 'Local Test City',
        'country_id': 1,
        'country': null,
        'lat': null,
        'lng': null,
      };
      expect(
        City.fromJson(json),
        const City(
          id: 1,
          name: 'Test City',
          localName: 'Local Test City',
          countryId: 1,
        ),
      );
    });

    test('can handle optional fields', () {
      const city = City(
        id: 1,
        name: 'Test City',
        localName: 'Local Test City',
        countryId: 1,
        country: Country(
          id: 1,
          name: 'Test Country',
          code: 'TC',
          continentId: 1,
        ),
        latitude: 12.34,
        longitude: 56.78,
      );
      final json = {
        'id': 1,
        'name': 'Test City',
        'local_name': 'Local Test City',
        'country_id': 1,
        'country': {
          'id': 1,
          'name': 'Test Country',
          'code': 'TC',
          'continent_id': 1,
        },
        'lat': 12.34,
        'lng': 56.78,
      };
      expect(City.fromJson(json), city);
      expect(city.toJson(), json);
    });
  });
}
