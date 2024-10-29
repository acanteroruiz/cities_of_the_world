import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:cities_of_the_world/debug_constants.dart';
import 'package:cities_of_the_world/features/cities/repository/cities_repository.dart';
import 'package:equatable/equatable.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit({CitiesRepository? citiesRepository})
      : _citiesRepository = citiesRepository ??
            ConnectCitiesRepository(
              apiClient: ApiClient.demo(
                baseUrl: connectEndpoint,
              ),
            ),
        super(
          const CitiesState(),
        );

  final CitiesRepository _citiesRepository;

  Future<void> getCities({
    int page = 1,
    bool includeCountry = false,
    String? filter,
  }) async {
    emit(
      state.copyWith(
        status: CitiesStatus.loading,
      ),
    );
    try {
      final cities = await _citiesRepository.getCities(
        page: page,
        includeCountry: includeCountry,
        filter: filter,
      );
      emit(
        state.copyWith(
          status: CitiesStatus.success,
          cities: cities,
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
}
