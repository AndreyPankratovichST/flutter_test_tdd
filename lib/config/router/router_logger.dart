import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_tdd/core/logger/logger.dart';

final class RouterLogger extends AutoRouteObserver {
  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    Logger.info(
      'didChangeTop: current route ${topRoute.settings.name}, previous route ${previousTopRoute?.settings.name}',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Logger.info(
      'didPop: popped ${route.settings.name}, back to ${previousRoute?.settings.name}',
    );
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Logger.info(
      'didPush: navigated to ${route.settings.name}, previous route ${previousRoute?.settings.name}',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Logger.info(
      'didRemove: removed route ${route.settings.name}, previous route ${previousRoute?.settings.name}',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    Logger.info(
      'didReplace: replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}',
    );
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    Logger.info(
      'didStartUserGesture: started gesture on ${route.settings.name}, previous route ${previousRoute?.settings.name}',
    );
  }

  @override
  void didStopUserGesture() {
    Logger.info('didStopUserGesture: user gesture stopped');
  }
}
