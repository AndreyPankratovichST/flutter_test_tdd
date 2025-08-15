import 'package:auto_route/auto_route.dart';
import 'package:flutter_test_tdd/config/router/router_app.gr.dart';
import 'package:flutter_test_tdd/config/router/routes.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';

final biometryRoute = CustomRoute(
  path: Routes.biometry,
  page: BiometryRoute.page,
  transitionsBuilder: TransitionsBuilders.fadeIn,
  duration: animationDurationFast,
  reverseDuration: animationDurationFast,
  barrierDismissible: true,
  opaque: false,
);
