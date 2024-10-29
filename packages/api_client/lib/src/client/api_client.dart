import 'dart:convert';
import 'dart:io';

import 'package:api_client/src/data/responses/cities_response.dart';
import 'package:http/http.dart' as http;

/// {@template api_malformed_response}
/// An exception thrown when there is a problem decoded the response body.
/// {@endtemplate}
class ApiMalformedResponse implements Exception {
  /// {@macro api_malformed_response}
  const ApiMalformedResponse({required this.error});

  /// The associated error.
  final Object error;
}

/// {@template api_request_failure}
/// An exception thrown when an http request failure occurs.
/// {@endtemplate}
class ApiRequestFailure implements Exception {
  /// {@macro api_request_failure}
  const ApiRequestFailure({
    required this.statusCode,
    required this.body,
  });

  /// The associated http status code.
  final int statusCode;

  /// The associated response body.
  final Map<String, dynamic> body;
}

/// {@template api_client}
/// A Dart API client for the Cities of the World API.
/// {@endtemplate}
class ApiClient {
  /// Create an instance of [ApiClient] that integrates
  /// with the remote API.
  ///
  /// {@macro api_client}
  ApiClient({
    required String baseUrl,
    http.Client? httpClient,
  }) : this._(
          baseUrl: baseUrl,
          httpClient: httpClient,
        );

  /// Create an instance of [ApiClient] that integrates
  /// with a local instance of the API (http://localhost:8000).
  ///
  /// {@macro api_client}
  ApiClient.localhost({
    required String baseUrl,
    http.Client? httpClient,
  }) : this._(
          baseUrl: baseUrl,
          httpClient: httpClient,
        );

  /// Create an instance of [ApiClient] that integrates
  /// with a demo instance of the API .
  ///
  /// {@macro api_client}
  ApiClient.demo({
    required String baseUrl,
    http.Client? httpClient,
  }) : this._(
          baseUrl: baseUrl,
          httpClient: httpClient,
        );

  /// {@macro api_client}
  ApiClient._({
    required String baseUrl,
    http.Client? httpClient,
  })  : _baseUrl = baseUrl,
        _httpClient = httpClient ?? http.Client();

  final String _baseUrl;
  final http.Client _httpClient;

  /// GET /city
  /// Requests cities metadata.
  ///
  /// Supported parameters:
  /// * [page] - The page number to request.
  /// * [filter] - A string to filter the results by city name.
  /// * [includeCountry] - Whether to include the country information.
  Future<CitiesResponse> getCities({
    int page = 1,
    String? filter,
    bool includeCountry = false,
  }) async {
    final pageParameter = 'page=$page';
    final includeParameter = includeCountry ? '&include=country' : '';
    final filterParameter =
        filter != null ? 'filter[0][name][contains]=$filter&' : '';

    final uri = Uri.parse(
      '$_baseUrl/city?$filterParameter$pageParameter$includeParameter',
    );

    final response = await _httpClient.get(
      uri,
      headers: await _getRequestHeaders(),
    );
    _throwIfNotOk(response);

    final body = response.json();

    return CitiesResponse.fromJson(
      body['data'] as Map<String, dynamic>,
    );
  }

  Future<Map<String, String>> _getRequestHeaders() async {
    return <String, String>{
      HttpHeaders.contentTypeHeader: ContentType.json.value,
      HttpHeaders.acceptHeader: ContentType.json.value,
    };
  }

  void _throwIfNotOk(http.Response response) {
    if (response.statusCode != HttpStatus.ok) {
      throw ApiRequestFailure(
        body: response.json(),
        statusCode: response.statusCode,
      );
    }
  }
}

extension on http.Response {
  Map<String, dynamic> json() {
    try {
      return jsonDecode(body) as Map<String, dynamic>;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        ApiMalformedResponse(error: error),
        stackTrace,
      );
    }
  }
}
