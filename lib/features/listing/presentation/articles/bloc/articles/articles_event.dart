part of 'articles_bloc.dart';

sealed class ArticlesEvent extends Equatable {
  const ArticlesEvent();
}

final class GetArticlesEvent extends ArticlesEvent {
  @override
  List<Object> get props => [];
}