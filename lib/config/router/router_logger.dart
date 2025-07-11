import 'package:flutter/widgets.dart';
import 'package:flutter_test_tdd/core/logger/logger.dart';

final class RouterLogger extends NavigatorObserver {
  final logger = Logger();
  
  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    logger.info('didChangeTop: current route ${topRoute.settings
        .name}, previous route ${previousTopRoute?.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.info('didPop: popped ${route.settings.name}, back to ${previousRoute
        ?.settings.name}');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.info('didPush: navigated to ${route.settings
        .name}, previous route ${previousRoute?.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.info('didRemove: removed route ${route.settings
        .name}, previous route ${previousRoute?.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    logger.info('didReplace: replaced ${oldRoute?.settings.name} with ${newRoute
        ?.settings.name}');
  }

  @override
  void didStartUserGesture(Route<dynamic> route,
      Route<dynamic>? previousRoute) {
    logger.info('didStartUserGesture: started gesture on ${route.settings
        .name}, previous route ${previousRoute?.settings.name}');
  }

  @override
  void didStopUserGesture() {
    logger.info('didStopUserGesture: user gesture stopped');
  }
}