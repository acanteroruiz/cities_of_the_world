import 'package:api_client/api_client.dart';
import 'package:cities_of_the_world/features/cities/bloc/cities_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CitiesState', () {
    test('supports value comparisons', () {
      expect(
        const CitiesState(),
        const CitiesState(),
      );
    });

    test('initial props are correct', () {
      expect(
        const CitiesState().props,
        [CitiesStatus.initial, const <City>[], 0, ''],
      );
    });

    test('copyWith returns the same object if no parameters are provided', () {
      expect(
        const CitiesState().copyWith(),
        const CitiesState(),
      );
    });

    test(
        'copyWith retains the old value for every parameter '
        'if null is provided', () {
      expect(
        const CitiesState().copyWith(),
        const CitiesState(),
      );
    });

    test('copyWith replaces every non-null parameter', () {
      final cities = [
        const City(
          id: 1,
          name: 'name',
          localName: 'local_name',
          countryId: 1,
        ),
      ];
      expect(
        const CitiesState().copyWith(
          status: CitiesStatus.success,
          cities: cities,
          currentPage: 1,
        ),
        CitiesState(
          status: CitiesStatus.success,
          cities: cities,
          currentPage: 1,
        ),
      );
    });

    test('toJson returns correct map', () {
      final cities = [
        const City(
          id: 1,
          name: 'name',
          localName: 'local_name',
          countryId: 1,
        ),
      ];
      final state = CitiesState(
        status: CitiesStatus.success,
        cities: cities,
        currentPage: 1,
        currentFilter: 'filter',
      );
      expect(
        state.toJson(),
        {
          'cities': [
            {
              'id': 1,
              'name': 'name',
              'local_name': 'local_name',
              'country_id': 1,
              'country': null,
              'lat': null,
              'lng': null,
            },
          ],
          'current_page': 1,
          'current_filter': 'filter',
        },
      );
    });

    test('fromJson returns correct state', () {
      final json = {
        'cities': [
          {
            'id': 1,
            'name': 'name',
            'local_name': 'local_name',
            'country_id': 1,
          },
        ],
      };
      expect(
        CitiesState.fromJson(json),
        const CitiesState(
          cities: [
            City(
              id: 1,
              name: 'name',
              localName: 'local_name',
              countryId: 1,
            ),
          ],
        ),
      );
    });
  });
}
