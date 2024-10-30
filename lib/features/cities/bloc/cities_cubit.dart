import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:cities_of_the_world/debug_constants.dart';
import 'package:cities_of_the_world/features/cities/repository/cities_repository.dart';
import 'package:cities_of_the_world/features/cities/repository/cities_repository_interface.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:equatable/equatable.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit({CitiesRepositoryInterface? citiesRepository})
      : _citiesRepository = citiesRepository ??
            ConnectCitiesRepository(
              apiClient: ApiClient.demo(
                baseUrl: connectEndpoint,
              ),
            ),
        super(const CitiesState());

  final CitiesRepositoryInterface _citiesRepository;

  Future<void> fetchCities({
    String filter = '',
  }) async {
    emit(
      state.copyWith(
        status: CitiesStatus.loading,
      ),
    );
    try {
      final newSearch = state.currentFilter != filter;
      final newPage = newSearch ? 1 : state.currentPage + 1;

      final cities = await _citiesRepository.getCities(
        page: newPage,
        includeCountry: true,
        filter: filter,
      );

      final updatedCities = state.currentFilter == filter
          ? [
              ...state.cities,
              ...cities,
            ]
          : cities;

      emit(
        state.copyWith(
          status: CitiesStatus.success,
          cities: updatedCities,
          currentPage: newPage,
          currentFilter: filter,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CitiesStatus.failure,
        ),
      );
    }
  }

  Future<void> updatePage() async {
    EasyThrottle.throttle(
      'throttle-cities-fetch',
      const Duration(milliseconds: 2000),
      () async => fetchCities(
        filter: state.currentFilter,
      ),
    );
  }
}
