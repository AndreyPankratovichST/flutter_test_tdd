import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_test_tdd/features/app/domain/usecase/get_deeplink_stream.dart';
import 'package:flutter_test_tdd/features/app/domain/usecase/get_init_deeplink.dart';
import 'package:meta/meta.dart';

part 'deeplink_event.dart';

part 'deeplink_state.dart';

class DeepLinkBloc extends Bloc<DeepLinkEvent, DeepLinkState> {
  final GetInitDeeplinkUseCase _getInitDeeplink;
  final GetDeepLinkStreamUseCase _getDeepLinkStream;

  StreamSubscription? _subscription;

  DeepLinkBloc(this._getInitDeeplink, this._getDeepLinkStream)
    : super(DeepLinkInitial()) {
    on<DeepLinkUpdateEvent>(_onDeeplinkUpdateEvent);
    _initDeepLinkBloc().then((value) => add(DeepLinkUpdateEvent(deeplink: value)));
  }

  Future<Uri?> _initDeepLinkBloc() async {
    final initialLink = (await _getInitDeeplink()).data;
    _subscription = _getDeepLinkStream.execute().listen(_handleDataStream);
    return initialLink;
  }

  void _handleDataStream(Uri? deepLink) {
    if (deepLink != null) {
      add(DeepLinkUpdateEvent(deeplink: deepLink));
    }
  }

  Future<void> _onDeeplinkUpdateEvent(
    DeepLinkUpdateEvent event,
    Emitter<DeepLinkState> emit,
  ) async {
    final deeplink = event.deeplink;
    if (deeplink != null) {
      emit(DeepLinkLoaded(deeplink));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
