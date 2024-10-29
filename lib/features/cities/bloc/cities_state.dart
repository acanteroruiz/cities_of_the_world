part of 'cities_cubit.dart';

enum CitiesStatus { initial, loading, success, failure }

class CitiesState extends Equatable {
  const CitiesState({
    this.cities = const <City>[],
    this.status = CitiesStatus.initial,
  });

  final CitiesStatus status;
  final List<City> cities;

  @override
  List<Object> get props => [
        cities,
        status,
      ];

  CitiesState copyWith({
    List<City>? cities,
    CitiesStatus? status,
  }) {
    return CitiesState(
      cities: cities ?? this.cities,
      status: status ?? this.status,
    );
  }
}
