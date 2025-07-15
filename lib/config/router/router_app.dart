import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_tdd/config/router/router_app.gr.dart';
import 'package:flutter_test_tdd/config/router/routes.dart';
import 'package:flutter_test_tdd/features/listing/presentation/route/listing_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
final class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: Routes.home,
      page: HomeRoute.page,
      initial: true,
      children: [listingRoute],
    ),
  ];
}

@RoutePage()
final class ContainerScreen extends StatelessWidget {
  const ContainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}
