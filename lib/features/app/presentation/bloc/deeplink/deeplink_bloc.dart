import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_tdd/core/logger/logger.dart';
import 'package:meta/meta.dart';

part 'deeplink_event.dart';

part 'deeplink_state.dart';

class DeeplinkBloc extends Bloc<DeeplinkEvent, DeeplinkState> {
  static const deepLinkChannel = 'com.example.flutter_test_tdd/channel';
  static const deepLinkEvent = 'com.example.flutter_test_tdd/event';
  static const methodDeepLinkInit = 'deepLinkInit';

  late final MethodChannel _methodChannel;
  late final EventChannel _eventChannel;

  StreamSubscription? _subscription;

  DeeplinkBloc() : super(DeeplinkInitial()) {
    on<DeeplinkInitialEvent>(_onDeeplinkInitialEvent);
    on<DeeplinkUpdateEvent>(_onDeeplinkUpdateEvent);
  }

  Future<String?> _initDeepLink() async {
    _methodChannel = const MethodChannel(deepLinkChannel);
    _eventChannel = const EventChannel(deepLinkEvent);
    _subscription = _eventChannel.receiveBroadcastStream().listen(
      _handleDataStream,
    );
    try {
      final initialLink = await _methodChannel.invokeMethod(
        methodDeepLinkInit,
      );
      return initialLink.toString();
    } catch (e) {
      Logger.error(e.toString());
      return null;
    }
  }

  void _handleDataStream(dynamic deepLink) {
    if (deepLink != null) {
      add(DeeplinkUpdateEvent(deeplink: deepLink.toString()));
    }
  }

  Future<void> _onDeeplinkInitialEvent(
    DeeplinkInitialEvent event,
    Emitter<DeeplinkState> emit,
  ) async {
    final initialLink = await _initDeepLink();
    emit(DeeplinkLoaded(initialLink));
  }

  Future<void> _onDeeplinkUpdateEvent(
    DeeplinkUpdateEvent event,
    Emitter<DeeplinkState> emit,
  ) async => emit(DeeplinkLoaded(event.deeplink));

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
