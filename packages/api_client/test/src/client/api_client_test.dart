import 'dart:convert';
import 'dart:io';

import 'package:api_client/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  Matcher isAUriHaving({String? authority, String? path, String? query}) {
    return predicate<Uri>((uri) {
      authority ??= uri.authority;
      path ??= uri.path;
      query ??= uri.query;

      return uri.authority == authority &&
          uri.path == path &&
          uri.query == query;
    });
  }

  Matcher areJsonHeaders({String? authorizationToken}) {
    return predicate<Map<String, String>?>((headers) {
      if (headers?[HttpHeaders.contentTypeHeader] != ContentType.json.value ||
          headers?[HttpHeaders.acceptHeader] != ContentType.json.value) {
        return false;
      }
      if (authorizationToken != null &&
          headers?[HttpHeaders.authorizationHeader] !=
              'Bearer $authorizationToken') {
        return false;
      }
      return true;
    });
  }

  group('ApiClient', () {
    late http.Client httpClient;
    late ApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(Uri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = ApiClient(
        baseUrl: 'http://example.com',
        httpClient: httpClient,
      );
    });

    group('localhost constructor', () {
      test('can be instantiated (no params)', () {
        expect(
          () => ApiClient.localhost(
            baseUrl: 'http://localhost:8080',
          ),
          returnsNormally,
        );
      });

      test('has correct baseUrl', () async {
        when(() => httpClient.get(any(), headers: any(named: 'headers')))
            .thenAnswer(
          (_) async => http.Response(
            jsonEncode({
              'data': const CitiesResponse(
                cities: [],
                pagination: Pagination(
                  currentPage: 1,
                  lastPage: 10,
                  perPage: 10,
                  total: 100,
                ),
              ),
            }),
            HttpStatus.ok,
          ),
        );
        final apiClient = ApiClient.localhost(
          baseUrl: 'http://localhost:8080',
          httpClient: httpClient,
        );

        await apiClient.getCities();

        verify(
          () => httpClient.get(
            any(that: isAUriHaving(authority: 'localhost:8080')),
            headers: any(named: 'headers', that: areJsonHeaders()),
          ),
        ).called(1);
      });
    });

    group('default constructor', () {
      test('can be instantiated (no params).', () {
        expect(
          () => ApiClient(
            baseUrl: 'http://example.com',
          ),
          returnsNormally,
        );
      });

      test('has correct baseUrl.', () async {
        when(() => httpClient.get(any(), headers: any(named: 'headers')))
            .thenAnswer(
          (_) async => http.Response(
            jsonEncode({
              'data': const CitiesResponse(
                cities: [],
                pagination: Pagination(
                  currentPage: 1,
                  lastPage: 10,
                  perPage: 10,
                  total: 100,
                ),
              ),
            }),
            HttpStatus.ok,
          ),
        );
        final apiClient = ApiClient(
          baseUrl: 'http://example.com',
          httpClient: httpClient,
        );

        await apiClient.getCities();
        verify(
          () => httpClient.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).called(1);
      });
    });
  });
}
