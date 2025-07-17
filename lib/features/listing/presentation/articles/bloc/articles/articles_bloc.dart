import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_articles.dart';

part 'articles_event.dart';

part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final GetArticlesUseCase _getArticlesUseCase;

  ArticlesBloc(this._getArticlesUseCase) : super(ArticlesInitialState()) {
    on<GetArticlesEvent>(_getArticles);
  }

  Future<void> _getArticles(
    GetArticlesEvent event,
    Emitter<ArticlesState> emit,
  ) async {
    final result = await _getArticlesUseCase();
    result.fold(
      onSuccess: (value) => emit(ArticlesSuccessState(value)),
      onFailure: (failure) => emit(ArticlesErrorState(failure)),
    );
  }
}
