import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/core/usecase/result.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_articles.dart';
import 'package:flutter_test_tdd/features/listing/presentation/articles/bloc/articles/articles_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'articles_bloc_test.mocks.dart';

@GenerateMocks([GetArticlesUseCase])
void main() {
  late ArticlesBloc bloc;
  late MockGetArticlesUseCase mockGetArticlesUseCase;

  setUp(() {
    mockGetArticlesUseCase = MockGetArticlesUseCase();
    bloc = ArticlesBloc(mockGetArticlesUseCase);
  });

  final tListing = [
    ListItemEntity(id: 1, title: 'item #1', date: DateTime(2025, 1, 10)),
  ];

  group('Articles bloc', () {
    test('initialState should be ArticlesInitialState', () {
      expect(bloc.state, equals(ArticlesInitialState()));
    });

    test('should emit when call get articles event returns success', () async {
      final result = Result(data: tListing, failure: null);
      provideDummy<Result<List<ListItemEntity>>>(result);

      when(mockGetArticlesUseCase()).thenAnswer((_) async => result);

      final expected = [
        isA<ArticlesSuccessState>().having((s) => s.listing, 'articles', tListing),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetArticlesEvent());
    });

    test('should emit when call get articles event returns failure', () async {
      final failure = ServerFailure('Server Failure');
      final result = Result<List<ListItemEntity>>(data: null, failure: failure);
      provideDummy<Result<List<ListItemEntity>>>(result);

      when(mockGetArticlesUseCase()).thenAnswer((_) async => result);

      final expected = [
        isA<ArticlesErrorState>().having((s) => s.failure, 'failure', failure),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetArticlesEvent());
    });
  });
}
