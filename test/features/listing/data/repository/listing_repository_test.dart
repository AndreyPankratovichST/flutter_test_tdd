import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/utils/network_info.dart';
import 'package:flutter_test_tdd/features/listing/data/model/description_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/repository/listing_repository_impl.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_local_data_source.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_remote_data_source.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'listing_repository_test.mocks.dart';

@GenerateMocks([
  ListingRepository,
  ListingRemoteDataSource,
  ListingLocalDataSource,
  NetworkInfo,
])
void main() {
  late ListingRepository repository;
  late MockListingRemoteDataSource mockRemoteDataSource;
  late MockListingLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockListingRemoteDataSource();
    mockLocalDataSource = MockListingLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ListingRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tItemId = 1;
  final tListItemDto = ListItemDto(
    id: tItemId,
    title: 'item #1',
    date: DateTime(2025, 1, 10),
  );
  final ListItemEntity tListItemEntity = tListItemDto.toEntity();
  final tDescriptionItemDto = DescriptionItemDto(
    id: tListItemDto.id,
    title: tListItemDto.title,
    date: tListItemDto.date,
    description: 'Is description',
    image: 'image.png',
  );
  final tDescriptionItemEntity = tDescriptionItemDto.toEntity();

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getListing', () {
    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockRemoteDataSource.getListing(),
      ).thenAnswer((_) async => [tListItemDto]);

      await repository.getListing();

      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          when(
            mockRemoteDataSource.getListing(),
          ).thenAnswer((_) async => [tListItemDto]);

          final result = await repository.getListing();

          verify(mockRemoteDataSource.getListing());
          expect(result, equals([tListItemEntity]));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          when(
            mockRemoteDataSource.getListing(),
          ).thenAnswer((_) async => [tListItemDto]);

          await repository.getListing();

          verify(mockRemoteDataSource.getListing());
          verify(mockLocalDataSource.cacheListing([tListItemDto]));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          when(
            mockLocalDataSource.getListing(),
          ).thenAnswer((_) async => [tListItemDto]);

          final result = await repository.getListing();

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getListing());
          expect(result, equals([tListItemDto.toEntity()]));
        },
      );
    });
  });

  group('getDescription', () {
    test('should check if the device is online', () {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockRemoteDataSource.getDescription(tItemId),
      ).thenAnswer((_) async => tDescriptionItemDto);

      repository.getDescription(tItemId);

      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          when(
            mockRemoteDataSource.getDescription(tItemId),
          ).thenAnswer((_) async => tDescriptionItemDto);

          final result = await repository.getDescription(tItemId);

          verify(mockRemoteDataSource.getDescription(tItemId));
          expect(result, equals(tDescriptionItemEntity));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          when(
            mockRemoteDataSource.getDescription(tItemId),
          ).thenAnswer((_) async => tDescriptionItemDto);

          await repository.getDescription(tItemId);

          verify(mockRemoteDataSource.getDescription(tItemId));
          verify(mockLocalDataSource.cacheDescription(tDescriptionItemDto));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          when(
            mockLocalDataSource.getDescription(tItemId),
          ).thenAnswer((_) async => tDescriptionItemDto);

          final result = await repository.getDescription(tItemId);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getDescription(tItemId));
          expect(result, equals(tDescriptionItemEntity));
        },
      );
    });
  });
}
