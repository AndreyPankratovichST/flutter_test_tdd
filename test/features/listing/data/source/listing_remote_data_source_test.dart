import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import 'listing_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late ListingRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = ListingRemoteDataSourceImpl(dio: mockDio);
  });

  group('get listing', () {
    test('should preform a GET request on a URL', () {
      when(mockDio.get<List<ListItemDto>>(any)).thenAnswer(
        (_) async => Response(
          data: [ListItemDto.fromJson(jsonDecode(fixture('list_item.json')))],
          requestOptions: RequestOptions(),
        ),
      );

      dataSource.getListing();

      verify(mockDio.get<List<ListItemDto>>('/listing'));
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
          () async {
        when(mockDio.get<List<ListItemDto>>(any)).thenAnswer(
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
