import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_tdd/config/router/router_app.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
final class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      page: HomeRoute.page,
      initial: true,
      children: [
        AutoRoute(path: 'dashboard', page: DashboardRoute.page),
        AutoRoute(
          path: 'listing',
          page: ContainerRoute.page,
          children: [
            AutoRoute(path: '', page: ListingRoute.page),
            AutoRoute(path: 'description', page: DescriptionRoute.page),
          ],
        ),
      ],
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