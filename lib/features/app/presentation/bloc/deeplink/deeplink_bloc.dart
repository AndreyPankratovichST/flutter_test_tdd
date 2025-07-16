import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_tdd/core/logger/logger.dart';
import 'package:meta/meta.dart';

part 'deeplink_event.dart';

part 'deeplink_state.dart';

class DeepLinkBloc extends Bloc<DeepLinkEvent, DeepLinkState> {
  static const deepLinkChannel = 'com.example.flutter_test_tdd/channel';
  static const deepLinkEvent = 'com.example.flutter_test_tdd/event';
  static const methodDeepLinkInit = 'deepLinkInit';

  late final MethodChannel _methodChannel;
  late final EventChannel _eventChannel;

  StreamSubscription? _subscription;

  DeepLinkBloc() : super(DeepLinkInitial()) {
    on<DeepLinkUpdateEvent>(_onDeeplinkUpdateEvent);
    _initDeepLink().then(
      (value) => add(DeepLinkUpdateEvent(deeplink: value ?? '')),
    );
  }

  Future<String?> _initDeepLink() async {
    _methodChannel = const MethodChannel(deepLinkChannel);
    _eventChannel = const EventChannel(deepLinkEvent);
    _subscription = _eventChannel.receiveBroadcastStream().listen(
      _handleDataStream,
    );
    try {
      final initialLink = await _methodChannel.invokeMethod(methodDeepLinkInit);
      return initialLink.toString();
    } catch (e) {
      Logger.error(e.toString());
      return null;
    }
  }

  void _handleDataStream(dynamic deepLink) {
    if (deepLink != null) {
      add(DeepLinkUpdateEvent(deeplink: deepLink.toString()));
    }
  }

  Future<void> _onDeeplinkUpdateEvent(
    DeepLinkUpdateEvent event,
    Emitter<DeepLinkState> emit,
  ) async => emit(DeepLinkLoaded(event.deeplink));

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
