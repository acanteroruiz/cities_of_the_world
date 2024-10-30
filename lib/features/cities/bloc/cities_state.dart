part of 'cities_cubit.dart';

enum CitiesStatus { initial, loading, success, failure }

class CitiesState extends Equatable {
  const CitiesState({
    this.status = CitiesStatus.initial,
    this.cities = const <City>[],
    this.currentPage = 0,
  });

  final CitiesStatus status;
  final List<City> cities;
  final int currentPage;

  @override
  List<Object> get props => [
        status,
        cities,
        currentPage,
      ];

  CitiesState copyWith({
    List<City>? cities,
    CitiesStatus? status,
    int? currentPage,
  }) {
    return CitiesState(
      status: status ?? this.status,
      cities: cities ?? this.cities,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
