import 'package:api_client/src/data/pagination.dart';
import 'package:api_client/src/models/city.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cities_response.g.dart';

/// {@template cities_response}
/// A cities response object which contains available.
/// {@endtemplate}
@JsonSerializable()
class CitiesResponse extends Equatable {
  /// {@macro cities_response}
  const CitiesResponse({
    required this.cities,
    required this.pagination,
  });

  /// Converts a `Map<String, dynamic>` into a [CitiesResponse] instance.
  factory CitiesResponse.fromJson(Map<String, dynamic> json) =>
      _$CitiesResponseFromJson(json);

  /// The available cities.
  @JsonKey(name: 'items')
  final List<City> cities;

  /// The response pagination metadata.
  @JsonKey(name: 'pagination')
  final Pagination pagination;

  /// Converts the current instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$CitiesResponseToJson(this);

  @override
  List<Object> get props => [
        cities,
        pagination,
      ];
}
