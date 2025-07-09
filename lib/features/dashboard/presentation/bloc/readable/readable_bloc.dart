import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'readable_event.dart';
part 'readable_state.dart';

class ReadableBloc extends Bloc<ReadableEvent, ReadableState> {
  ReadableBloc() : super(ReadableInitial()) {
    on<ReadableEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
