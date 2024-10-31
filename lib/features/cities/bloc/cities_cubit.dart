import 'package:api_client/api_client.dart';
import 'package:cities_of_the_world/debug_constants.dart';
import 'package:cities_of_the_world/features/cities/repository/cities_repository.dart';
import 'package:cities_of_the_world/features/cities/repository/cities_repository_interface.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'cities_state.dart';

class CitiesCubit extends HydratedCubit<CitiesState> {
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
    bool refresh = false,
  }) async {
    if (state.initialDataIsFromCache && !refresh) {
      return;
    }

    if (!state.initialDataIsFromCache && refresh) {
      emit(
        state.copyWith(
          status: CitiesStatus.loading,
        ),
      );
    }

    try {
      final newSearch = state.currentFilter != filter;
      final newPage = newSearch || refresh ? 1 : state.currentPage + 1;

      final cities = await _citiesRepository.getCities(
        page: newPage,
        includeCountry: true,
        filter: filter,
      );

      final updatedCities = newSearch || refresh
          ? cities
          : [
              ...state.cities,
              ...cities,
            ];

      emit(
        state.copyWith(
          status: state.initialDataIsFromCache && !refresh
              ? CitiesStatus.initial
              : CitiesStatus.success,
          cities: updatedCities,
          currentPage: newPage,
          currentFilter: filter,
        ),
      );
    } catch (e) {
      if (state.cities.isNotEmpty) {
        emit(
          state.copyWith(
            status: CitiesStatus.failure,
            cities: state.cities,
            currentPage: state.currentPage,
            currentFilter: state.currentFilter,
          ),
        );
      }
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

  void reset() {
    emit(const CitiesState());
  }

  @override
  CitiesState? fromJson(Map<String, dynamic> json) {
    return CitiesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CitiesState state) {
    return state.toJson();
  }
}
