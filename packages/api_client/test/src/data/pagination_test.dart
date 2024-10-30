import 'package:api_client/api_client.dart';
import 'package:test/test.dart';

void main() {
  group('Pagination', () {
    test('supports value comparisons', () {
      expect(
        const Pagination(
          currentPage: 1,
          lastPage: 10,
          perPage: 20,
          total: 200,
        ),
        const Pagination(
          currentPage: 1,
          lastPage: 10,
          perPage: 20,
          total: 200,
        ),
      );
    });

    test('can be serialized to JSON', () {
      const pagination = Pagination(
        currentPage: 1,
        lastPage: 10,
        perPage: 20,
        total: 200,
      );
      expect(
        pagination.toJson(),
        {
          'current_page': 1,
          'last_page': 10,
          'per_page': 20,
          'total': 200,
        },
      );
    });

    test('can be deserialized from JSON', () {
      final json = {
        'current_page': 1,
        'last_page': 10,
        'per_page': 20,
        'total': 200,
      };
      expect(
        Pagination.fromJson(json),
        const Pagination(
          currentPage: 1,
          lastPage: 10,
          perPage: 20,
          total: 200,
        ),
      );
    });
  });
}
