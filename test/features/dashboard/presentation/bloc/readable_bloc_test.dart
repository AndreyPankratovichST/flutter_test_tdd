import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/core/usecase/result.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/entity/readable_entity.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/usecase/get_readable.dart';
import 'package:flutter_test_tdd/features/dashboard/presentation/bloc/readable/readable_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'readable_bloc_test.mocks.dart';

@GenerateMocks([GetReadableUseCase])
void main() {
  late MockGetReadableUseCase mockUseCase;
  late ReadableBloc bloc;

  setUp(() {
    mockUseCase = MockGetReadableUseCase();
    bloc = ReadableBloc(mockUseCase);
  });

  final tReadableEntity = ReadableEntity(allReadable: 1, list: []);
  
  group('readable bloc', () {
    test('initialState should be ReadableInitialState', () {
      expect(bloc.state, equals(ReadableInitialState()));
    });

    test('should emit when call get readable event returns success', () async {
      final result = Result(data: tReadableEntity, failure: null);
      provideDummy<Result<ReadableEntity>>(result);

      when(mockUseCase(any)).thenAnswer((_) async => result);

      final expected = [
        isA<ReadableSuccessState>().having((s) => s.readable, 'Readable', tReadableEntity),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetReadableEvent());
    });

    test('should emit when call get readable event returns failure', () async {
      final failure = PlatformFailure('Platform Failure');
      final result = Result<ReadableEntity>(data: null, failure: failure);
      provideDummy<Result<ReadableEntity>>(result);

      when(mockUseCase(any)).thenAnswer((_) async => result);

      final expected = [
        isA<ReadableErrorState>().having((s) => s.failure, 'failure', failure),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetReadableEvent());
    });
  });
}