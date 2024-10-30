part of 'cities_cubit.dart';

enum CitiesStatus { initial, loading, success, failure }

class CitiesState extends Equatable {
  const CitiesState({
    this.status = CitiesStatus.initial,
    this.cities = const <City>[],
    this.currentPage = 0,
    this.currentFilter = '',
  });

  final CitiesStatus status;
  final List<City> cities;
  final int currentPage;
  final String currentFilter;

  @override
  List<Object> get props => [
        status,
        cities,
        currentPage,
        currentFilter,
      ];

  CitiesState copyWith({
    List<City>? cities,
    CitiesStatus? status,
    int? currentPage,
    String? currentFilter,
  }) {
    return CitiesState(
      status: status ?? this.status,
      cities: cities ?? this.cities,
      currentPage: currentPage ?? this.currentPage,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }
}
