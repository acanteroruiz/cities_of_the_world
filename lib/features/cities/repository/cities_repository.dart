import 'package:api_client/api_client.dart';

interface class CitiesRepository {
  Future<List<City>> getCities({
    required int page,
    required bool includeCountry,
    String? filter,
  }) {
    throw UnimplementedError();
  }
}

class ConnectCitiesRepository implements CitiesRepository {
  ConnectCitiesRepository({
    required this.apiClient,
  });

  final ApiClient apiClient;

  @override
  Future<List<City>> getCities({
    int page = 1,
    bool includeCountry = false,
    String? filter,
  }) async {
    try {
      final response = await apiClient.getCities(
        page: page,
        includeCountry: includeCountry,
        filter: filter,
      );
      return response.cities;
    } catch (e) {
      rethrow;
    }
  }
}
