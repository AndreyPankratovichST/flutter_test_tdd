part of 'articles_bloc.dart';

sealed class ArticlesState extends Equatable {
  const ArticlesState();
}

final class ArticlesInitialState extends ArticlesState {
  @override
  List<Object> get props => [];
}

final class ArticlesSuccessState extends ArticlesState {
  final List<ListItemEntity> listing;

  const ArticlesSuccessState(this.listing);

  @override
  List<Object> get props => [listing];
}

final class ArticlesErrorState extends ArticlesState {
  final Failure failure;

  const ArticlesErrorState(this.failure);

  @override
  List<Object> get props => [failure];
}
