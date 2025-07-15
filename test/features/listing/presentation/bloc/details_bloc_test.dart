import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/core/usecase/result.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/details_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_details.dart';
import 'package:flutter_test_tdd/features/listing/presentation/details/bloc/details/details_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'details_bloc_test.mocks.dart';

@GenerateMocks([GetDetailsUseCase])
void main() {
  late DetailsBloc bloc;
  late MockGetDetailsUseCase mockGetDetailsUseCase;

  setUp(() {
    mockGetDetailsUseCase = MockGetDetailsUseCase();
    bloc = DetailsBloc(mockGetDetailsUseCase);
  });

  final id = 1;
  final tDetails = DetailsItemEntity(
    id: id,
    title: 'item #1',
    date: DateTime(2025, 1, 10),
    description: 'This is a details',
    image: 'image.png',
  );

  group('Details bloc', () {
    test('initialState should be DetailsInitialState', () {
      expect(bloc.state, equals(DetailsInitialState()));
    });

    test('should emit when call get details event returns success', () async {
      final result = Result(data: tDetails, failure: null);
      provideDummy<Result<DetailsItemEntity>>(result);

      when(mockGetDetailsUseCase(params: any)).thenAnswer((_) async => result);

      final expected = [
        isA<DetailsSuccessState>().having((s) => s.details, 'details', tDetails),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetDetailsEvent(id));
    });

    test('should emit when call get details event returns failure', () async {
      final failure = ServerFailure('Server Failure');
      final result = Result<DetailsItemEntity>(data: null, failure: failure);
      provideDummy<Result<DetailsItemEntity>>(result);

      when(mockGetDetailsUseCase(params: any)).thenAnswer((_) async => result);

      final expected = [
        isA<DetailsErrorState>().having((s) => s.failure, 'failure', failure),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetDetailsEvent(id));
    });
  });
}
