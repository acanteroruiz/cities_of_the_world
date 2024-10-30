import 'package:api_client/api_client.dart';
import 'package:cities_of_the_world/features/cities/repository/cities_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('ConnectCitiesRepository', () {
    late ApiClient apiClient;
    late ConnectCitiesRepository citiesRepository;

    setUp(() {
      apiClient = MockApiClient();
      citiesRepository = ConnectCitiesRepository(apiClient: apiClient);
    });

    test('getCities returns list of cities on success', () async {
      final cities = [
        const City(
          id: 1,
          name: 'Test City',
          localName: 'Local Test City',
          countryId: 1,
        ),
      ];
      const pagination = Pagination(
        currentPage: 1,
        lastPage: 1,
        perPage: 10,
        total: 1,
      );
      final response = CitiesResponse(cities: cities, pagination: pagination);

      when(() => apiClient.getCities(
            page: any(named: 'page'),
            includeCountry: any(named: 'includeCountry'),
            filter: any(named: 'filter'),
          ),).thenAnswer((_) async => response);

      final result =
          await citiesRepository.getCities(includeCountry: true);

      expect(result, cities);
      verify(() => apiClient.getCities(
            includeCountry: true,
          ),).called(1);
    });

    test('getCities throws exception on failure', () async {
      when(() => apiClient.getCities(
            page: any(named: 'page'),
            includeCountry: any(named: 'includeCountry'),
            filter: any(named: 'filter'),
          ),).thenThrow(Exception('error'));

      expect(
        () async =>
            citiesRepository.getCities(includeCountry: true),
        throwsA(isA<Exception>()),
      );
    });
  });
}
