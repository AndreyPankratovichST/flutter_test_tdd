part of 'details_bloc.dart';

sealed class DetailsEvent extends Equatable {
  const DetailsEvent();
}

final class GetDetailsEvent extends DetailsEvent {
  final int id;

  const GetDetailsEvent(this.id);

  @override
  List<Object?> get props => [];
}
