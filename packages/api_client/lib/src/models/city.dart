import 'package:api_client/src/models/country.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

/// {@template city}
/// A City of the World.
/// {@endtemplate}
@JsonSerializable()
class City extends Equatable {
  /// {@macro city}
  const City({
    required this.id,
    required this.name,
    required this.localName,
    required this.countryId,
    this.country,
    this.latitude,
    this.longitude,
  });

  /// Converts a `Map<String, dynamic>` into a [City] instance.
  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  /// The city id
  final int id;

  /// The city name.
  final String name;

  /// The city local name.
  @JsonKey(name: 'local_name')
  final String localName;

  /// The city country id.
  @JsonKey(name: 'country_id')
  final int countryId;

  /// The city country.
  final Country? country;

  /// The city latitude.
  @JsonKey(name: 'lat')
  final double? latitude;

  /// The city longitude.
  @JsonKey(name: 'lng')
  final double? longitude;

  /// Converts the current instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$CityToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        localName,
        countryId,
        country,
        latitude,
        longitude,
      ];
}
