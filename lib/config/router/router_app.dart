import 'package:auto_route/auto_route.dart';
import 'package:flutter_test_tdd/config/router/router_app.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
final class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      initial: true,
      children: [
        AutoRoute(page: DashboardRoute.page),
        AutoRoute(page: ListingRoute.page),
      ],
    ),
    AutoRoute(page: DescriptionRoute.page),
  ];
}
