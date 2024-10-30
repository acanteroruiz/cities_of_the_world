import 'package:api_client/api_client.dart';
import 'package:cities_of_the_world/features/cities/repository/cities_repository_interface.dart';

class ConnectCitiesRepository implements CitiesRepositoryInterface {
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
