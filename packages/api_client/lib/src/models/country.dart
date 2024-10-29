import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

/// {@template country}
/// A Country of the World.
/// {@endtemplate}
@JsonSerializable()
class Country extends Equatable {
  /// {@macro country}
  const Country({
    required this.id,
    required this.name,
    required this.code,
    required this.continentId,
  });

  /// Converts a `Map<String, dynamic>` into a [Country] instance.
  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  /// The country id
  final int id;

  /// The country name.
  final String name;

  /// The country code.
  final String code;

  /// The country continent id.
  @JsonKey(name: 'continent_id')
  final int continentId;

  /// Converts the current instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        code,
        continentId,
      ];
}
