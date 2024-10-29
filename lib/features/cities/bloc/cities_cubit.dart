import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:cities_of_the_world/debug_constants.dart';
import 'package:cities_of_the_world/features/cities/repository/cities_repository.dart';
import 'package:easy_debounce/easy_throttle.dart';
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
    String? filter,
  }) async {
    emit(
      state.copyWith(
        status: CitiesStatus.loading,
      ),
    );
    try {
      final cities = await _citiesRepository.getCities(
        page: state.currentPage,
        includeCountry: true,
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

  Future<void> updatePage() async {
    EasyThrottle.throttle(
      'my-throttler',
      const Duration(milliseconds: 2000),
      () async {
        emit(
          state.copyWith(
            status: CitiesStatus.loading,
            currentPage: state.currentPage + 1,
          ),
        );

        return getCities();
      },
    );
    /* return EasyDebounce.debounce(
      'onScrollDebounce',
      const Duration(milliseconds: 750),
      () async {
        emit(
          state.copyWith(
            status: CitiesStatus.loading,
            currentPage: state.currentPage + 1,
          ),
        );

        return getCities();
      },
    );*/
  }
}
