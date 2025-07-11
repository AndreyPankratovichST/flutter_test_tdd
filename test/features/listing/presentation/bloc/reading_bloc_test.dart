import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/core/usecase/result.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/save_list_item.dart';
import 'package:flutter_test_tdd/features/listing/presentation/bloc/reading/reading_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reading_bloc_test.mocks.dart';


@GenerateMocks([SaveListItemUseCase])
void main() {
  late MockSaveListItemUseCase mockUseCase;
  late ReadingBloc bloc;

  setUp(() {
    mockUseCase = MockSaveListItemUseCase();
    bloc = ReadingBloc(mockUseCase);
  });

  final tListItemEntity = ListItemEntity(id: 1, title: 'item #1', date: DateTime(2025, 1, 10));

  group('Reading bloc', () {
    test('initialState should be ReadingInitialState', () {
      expect(bloc.state, equals(ReadingInitialState()));
    });

    test('should emit when call save item event returns success', () async {
      final result = Result(data: null, failure: null);
      provideDummy<Result<void>>(result);

      when(mockUseCase(any)).thenAnswer((_) async => result);

      final expected = [
        isA<ReadingSuccessOperationState>().having((s) => null, 'SaveOperation', null),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(SaveReadEvent(tListItemEntity));
    });

    test('should emit when call save item event returns failure', () async {
      final failure = PlatformFailure('Platform Failure');
      final result = Result<void>(data: null, failure: failure);
      provideDummy<Result<void>>(result);

      when(mockUseCase(any)).thenAnswer((_) async => result);

      final expected = [
        isA<ReadingErrorOperationState>().having((s) => s.failure, 'failure', failure),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(SaveReadEvent(tListItemEntity));
    });
  });
}