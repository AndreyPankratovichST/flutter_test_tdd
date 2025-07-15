import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/client/client.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import 'listing_remote_data_source_test.mocks.dart';

@GenerateMocks([AppClient])
void main() {
  late ApiListingRemoteDataSource dataSource;
  late MockAppClient mockClient;

  setUp(() {
    mockClient = MockAppClient();
    dataSource = ApiListingRemoteDataSource(mockClient);
    when(mockClient.options).thenReturn(BaseOptions());
  });

  group('get articles', () {
    test('should preform a GET request on a URL', () {
      when(mockClient.fetch<List<dynamic>>(any)).thenAnswer(
        (_) async => Response(
          data: [jsonDecode(fixture('list_item.json'))],
          requestOptions: RequestOptions(),
        ),
      );

      dataSource.getListing();

      verify(mockClient.fetch<List<dynamic>>(any));
    });
  });
}
