import 'package:api_client/src/models/country.dart';
import 'package:test/test.dart';

void main() {
  group('Country', () {
    test('supports value comparisons', () {
      expect(
        const Country(
          id: 1,
          name: 'Test Country',
          code: 'TC',
          continentId: 1,
        ),
        const Country(
          id: 1,
          name: 'Test Country',
          code: 'TC',
          continentId: 1,
        ),
      );
    });

    test('can be serialized to JSON', () {
      const country = Country(
        id: 1,
        name: 'Test Country',
        code: 'TC',
        continentId: 1,
      );
      expect(
        country.toJson(),
        {
          'id': 1,
          'name': 'Test Country',
          'code': 'TC',
          'continent_id': 1,
        },
      );
    });

    test('can be deserialized from JSON', () {
      final json = {
        'id': 1,
        'name': 'Test Country',
        'code': 'TC',
        'continent_id': 1,
      };
      expect(
        Country.fromJson(json),
        const Country(
          id: 1,
          name: 'Test Country',
          code: 'TC',
          continentId: 1,
        ),
      );
    });
  });
}
