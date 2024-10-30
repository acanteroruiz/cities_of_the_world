import 'package:api_client/api_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:cities_of_the_world/features/cities/bloc/cities_cubit.dart';
import 'package:cities_of_the_world/features/cities/repository/cities_repository_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:time/time.dart';

class MockCitiesRepository extends Mock implements CitiesRepositoryInterface {}

void main() {
  group('CitiesCubit', () {
    late CitiesRepositoryInterface citiesRepository;
    late CitiesCubit citiesCubit;

    setUp(() {
      citiesRepository = MockCitiesRepository();
      citiesCubit = CitiesCubit(citiesRepository: citiesRepository);
    });

    test('initial state is CitiesState', () {
      expect(citiesCubit.state, const CitiesState());
    });

    blocTest<CitiesCubit, CitiesState>(
      'emits [loading, success] when fetchCities succeeds',
      build: () {
        when(
          () => citiesRepository.getCities(
            page: any(named: 'page'),
            includeCountry: any(named: 'includeCountry'),
            filter: any(named: 'filter'),
          ),
        ).thenAnswer(
          (_) async => [
            const City(
              id: 1,
              name: 'Test City',
              localName: 'Local Test City',
              countryId: 1,
            ),
          ],
        );
        return citiesCubit;
      },
      act: (cubit) => cubit.fetchCities(),
      expect: () => [
        const CitiesState(status: CitiesStatus.loading),
        const CitiesState(
          status: CitiesStatus.success,
          cities: [
            City(
              id: 1,
              name: 'Test City',
              localName: 'Local Test City',
              countryId: 1,
            ),
          ],
          currentPage: 1,
        ),
      ],
    );

    blocTest<CitiesCubit, CitiesState>(
      'emits [loading, failure] when fetchCities fails',
      build: () {
        when(
          () => citiesRepository.getCities(
            page: any(named: 'page'),
            includeCountry: any(named: 'includeCountry'),
            filter: any(named: 'filter'),
          ),
        ).thenThrow(Exception('error'));
        return citiesCubit;
      },
      act: (cubit) => cubit.fetchCities(),
      expect: () => [
        const CitiesState(status: CitiesStatus.loading),
        const CitiesState(status: CitiesStatus.failure),
      ],
    );

    blocTest<CitiesCubit, CitiesState>(
      'throttles updatePage calls',
      build: () {
        when(
          () => citiesRepository.getCities(
            page: any(named: 'page'),
            includeCountry: any(named: 'includeCountry'),
            filter: any(named: 'filter'),
          ),
        ).thenAnswer(
          (_) async => [
            const City(
              id: 1,
              name: 'Test City',
              localName: 'Local Test City',
              countryId: 1,
            ),
          ],
        );
        return citiesCubit;
      },
      act: (cubit) async {
        await cubit.updatePage();
        await 1.seconds.delay;
        await cubit.updatePage();
      },
      expect: () => [
        const CitiesState(status: CitiesStatus.loading),
        const CitiesState(
          status: CitiesStatus.success,
          cities: [
            City(
              id: 1,
              name: 'Test City',
              localName: 'Local Test City',
              countryId: 1,
            ),
          ],
          currentPage: 1,
        ),
      ],
      verify: (_) {
        verify(
          () => citiesRepository.getCities(
            page: any(named: 'page'),
            includeCountry: any(named: 'includeCountry'),
            filter: any(named: 'filter'),
          ),
        ).called(1);
      },
    );
  });
}
