part of 'description_bloc.dart';

sealed class DescriptionEvent extends Equatable {
  const DescriptionEvent();
}

final class GetDescriptionEvent extends DescriptionEvent {
  final int id;

  const GetDescriptionEvent(this.id);

  @override
  List<Object?> get props => [];
}
