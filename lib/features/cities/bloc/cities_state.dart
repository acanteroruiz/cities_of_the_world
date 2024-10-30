part of 'cities_cubit.dart';

enum CitiesStatus { initial, loading, success, failure }

class CitiesState extends Equatable {
  const CitiesState({
    this.status = CitiesStatus.initial,
    this.cities = const <City>[],
    this.currentPage = 0,
    this.currentFilter = '',
  });

  factory CitiesState.fromJson(Map<String, dynamic> json) {
    return CitiesState(
      cities: (json['cities'] as List)
          .map(
            (e) => City.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cities': cities.map((e) => e.toJson()).toList(),
      'current_page': currentPage,
      'current_filter': currentFilter,
    };
  }

  final CitiesStatus status;
  final List<City> cities;
  final int currentPage;
  final String currentFilter;

  bool get initialDataIsFromCache =>
      status == CitiesStatus.initial && cities.isNotEmpty;

  String get hintLabel {
    final hintLabelRecord = (status, cities.isEmpty);
    return switch (hintLabelRecord) {
      (CitiesStatus.initial, false) => 'Last search, tap to refresh',
      (CitiesStatus.failure, false) => 'No connection, last search',
      (_, _) => 'Search cities',
    };
  }

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
