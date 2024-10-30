import 'package:api_client/api_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:cities_of_the_world/features/cities/bloc/cities_cubit.dart';
import 'package:cities_of_the_world/features/cities/repository/cities_repository_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:time/time.dart';

class MockCitiesRepository extends Mock implements CitiesRepositoryInterface {}

class MockStorage extends Mock implements Storage {}

const fakeCity = City(
  id: 1,
  name: 'Test City',
  localName: 'Local Test City',
  countryId: 1,
);

void main() {
  late Storage storage;
  setUp(() {
    storage = MockStorage();
    when(
      () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  });
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
      'emits [success] when fetchCities succeeds '
      'and initial data is from cache',
      build: () {
        when(
          () => citiesRepository.getCities(
            page: any(named: 'page'),
            includeCountry: any(named: 'includeCountry'),
            filter: any(named: 'filter'),
          ),
        ).thenAnswer(
          (_) async => [
            fakeCity,
          ],
        );
        return citiesCubit;
      },
      act: (cubit) => cubit.fetchCities(),
      expect: () => [
        // const CitiesState(status: CitiesStatus.loading),
        const CitiesState(
          status: CitiesStatus.success,
          cities: [
            fakeCity,
          ],
          currentPage: 1,
        ),
      ],
    );

    blocTest<CitiesCubit, CitiesState>(
      'emits [loading, success] when fetchCities succeeds '
      'and initial data is not from cache',
      build: () {
        when(
          () => citiesRepository.getCities(
            page: any(named: 'page'),
            includeCountry: any(named: 'includeCountry'),
            filter: any(named: 'filter'),
          ),
        ).thenAnswer(
          (_) async => [
            fakeCity,
          ],
        );
        return citiesCubit;
      },
      act: (cubit) => cubit.fetchCities(refresh: true),
      expect: () => [
        const CitiesState(status: CitiesStatus.loading),
        const CitiesState(
          status: CitiesStatus.success,
          cities: [
            fakeCity,
          ],
          currentPage: 1,
        ),
      ],
    );

    blocTest<CitiesCubit, CitiesState>(
      'emits [loading, failure] when fetchCities fails '
      'and initial data is not from cache',
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
      seed: () => const CitiesState(
        status: CitiesStatus.success,
        cities: [
          fakeCity,
        ],
        currentPage: 1,
      ),
      act: (cubit) => cubit.fetchCities(refresh: true),
      expect: () => [
        const CitiesState(
          status: CitiesStatus.loading,
          currentPage: 1,
          cities: [
            fakeCity,
          ],
        ),
        const CitiesState(
          status: CitiesStatus.failure,
          currentPage: 1,
          cities: [
            fakeCity,
          ],
        ),
      ],
    );

    blocTest<CitiesCubit, CitiesState>(
      'emits [failure] when fetchCities fails '
      'and initial data is from cache',
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
      seed: () => const CitiesState(
        status: CitiesStatus.success,
        cities: [
          fakeCity,
        ],
        currentPage: 1,
      ),
      act: (cubit) => cubit.fetchCities(),
      expect: () => [
        const CitiesState(
          status: CitiesStatus.failure,
          currentPage: 1,
          cities: [
            fakeCity,
          ],
        ),
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
            fakeCity,
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
        const CitiesState(
          status: CitiesStatus.success,
          cities: [
            fakeCity,
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
