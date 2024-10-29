part of 'cities_cubit.dart';

enum CitiesStatus { initial, loading, success, failure }

class CitiesState extends Equatable {
  const CitiesState({
    this.status = CitiesStatus.initial,
    this.cities = const <City>[],
    this.currentPage = 1,
    this.hasReachedMax = false,
  });

  final CitiesStatus status;
  final List<City> cities;
  final int currentPage;
  final bool hasReachedMax;

  @override
  List<Object> get props => [
        status,
        cities,
        currentPage,
        hasReachedMax,
      ];

  CitiesState copyWith({
    List<City>? cities,
    CitiesStatus? status,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return CitiesState(
      status: status ?? this.status,
      cities: cities ?? this.cities,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
