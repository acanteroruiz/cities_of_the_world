import 'package:api_client/api_client.dart';

interface class CitiesRepositoryInterface {
  Future<List<City>> getCities({
    required int page,
    required bool includeCountry,
    String filter = '',
  }) {
    throw UnimplementedError();
  }
}
