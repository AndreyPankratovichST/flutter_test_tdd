part of 'reading_bloc.dart';

sealed class ReadingEvent extends Equatable {
  const ReadingEvent();
}

final class SaveReadEvent extends ReadingEvent {
  final ListItemEntity item;

  const SaveReadEvent(this.item);

  @override
  List<Object?> get props => [item];
}
