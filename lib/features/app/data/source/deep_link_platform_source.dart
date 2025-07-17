import 'dart:async';

import 'package:flutter/services.dart';

abstract class DeepLinkPlatformSource {
  Future<String?> getInitialDeepLink();

  Stream<dynamic> getDeepLinkStream();
}

class DeepLinkPlatformSourceImpl extends DeepLinkPlatformSource {
  static const deepLinkChannel = 'com.example.flutter_test_tdd/channel';
  static const deepLinkEvent = 'com.example.flutter_test_tdd/event';
  static const methodDeepLinkInit = 'deepLinkInit';

  late final MethodChannel _methodChannel;
  late final EventChannel _eventChannel;

  DeepLinkPlatformSourceImpl() {
    _methodChannel = const MethodChannel(deepLinkChannel);
    _eventChannel = const EventChannel(deepLinkEvent);
  }

  @override
  Future<String?> getInitialDeepLink() =>
      _methodChannel.invokeMethod(methodDeepLinkInit);

  @override
  Stream<dynamic> getDeepLinkStream() => _eventChannel.receiveBroadcastStream();
}
