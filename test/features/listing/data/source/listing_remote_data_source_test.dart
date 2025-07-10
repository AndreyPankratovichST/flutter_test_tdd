import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/client/client.dart';
import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import 'listing_remote_data_source_test.mocks.dart';

@GenerateMocks([AppClient])
void main() {
  late ListingRemoteDataSourceImpl dataSource;
  late MockAppClient mockClient;

  setUp(() {
    mockClient = MockAppClient();
    dataSource = ListingRemoteDataSourceImpl(dio: mockClient);
  });

  group('get listing', () {
    test('should preform a GET request on a URL', () {
      when(mockClient.get<List<ListItemDto>>(any)).thenAnswer(
        (_) async => Response(
          data: [ListItemDto.fromJson(jsonDecode(fixture('list_item.json')))],
          requestOptions: RequestOptions(),
        ),
      );

      dataSource.getListing();

      verify(mockClient.get<List<ListItemDto>>('/listing'));
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
          () async {
        when(mockClient.get<List<ListItemDto>>(any)).thenAnswer(
              (_) async => Response(
                data: null,
                statusCode: 404,
                requestOptions: RequestOptions(),
              ),
        );

        final call = dataSource.getListing();

        expect(call, throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
