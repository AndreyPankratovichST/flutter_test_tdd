import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/core/usecase/result.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/description_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_description.dart';
import 'package:flutter_test_tdd/features/listing/presentation/bloc/description/description_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'description_bloc_test.mocks.dart';

@GenerateMocks([GetDescriptionUseCase])
void main() {
  late DescriptionBloc bloc;
  late MockGetDescriptionUseCase mockGetDescriptionUseCase;

  setUp(() {
    mockGetDescriptionUseCase = MockGetDescriptionUseCase();
    bloc = DescriptionBloc(mockGetDescriptionUseCase);
  });

  final id = 1;
  final tDescription = DescriptionItemEntity(
    id: id,
    title: 'item #1',
    date: DateTime(2025, 1, 10),
    description: 'This is a description',
    image: 'image.png',
  );

  group('Description bloc', () {
    test('initialState should be DescriptionInitialState', () {
      expect(bloc.state, equals(DescriptionInitialState()));
    });

    test('should emit when call get description event returns success', () async {
      final result = Result(result: tDescription, failure: null);
      provideDummy<Result<DescriptionItemEntity>>(result);

      when(mockGetDescriptionUseCase(any)).thenAnswer((_) async => result);

      final expected = [
        isA<DescriptionSuccessState>().having((s) => s.description, 'description', tDescription),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetDescriptionEvent(id));
    });

    test('should emit when call get description event returns failure', () async {
      final failure = ServerFailure('Server Failure');
      final result = Result<DescriptionItemEntity>(result: null, failure: failure);
      provideDummy<Result<DescriptionItemEntity>>(result);

      when(mockGetDescriptionUseCase(any)).thenAnswer((_) async => result);

      final expected = [
        isA<DescriptionErrorState>().having((s) => s.failure, 'failure', failure),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetDescriptionEvent(id));
    });
  });
}
