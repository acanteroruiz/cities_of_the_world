import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

/// {@template pagination}
/// The pagination meta data of the API response.
/// {@endtemplate}
@JsonSerializable()
class Pagination extends Equatable {
  /// {@macro pagination}
  const Pagination({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  /// Converts a `Map<String, dynamic>` into a [Pagination] instance.
  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  /// The pagination id
  @JsonKey(name: 'current_page')
  final int currentPage;

  /// The pagination name.
  @JsonKey(name: 'last_page')
  final int lastPage;

  /// The pagination local name.
  @JsonKey(name: 'per_page')
  final int perPage;

  /// The total count.
  final int total;

  /// Converts the current instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$PaginationToJson(this);

  @override
  List<Object?> get props => [
        currentPage,
        lastPage,
        perPage,
        total,
      ];
}
