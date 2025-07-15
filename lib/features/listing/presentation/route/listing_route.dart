import 'package:auto_route/auto_route.dart';
import 'package:flutter_test_tdd/config/router/router_app.gr.dart';
import 'package:flutter_test_tdd/config/router/routes.dart';

final listingRoute = AutoRoute(
  path: '${Routes.listing}/',
  page: ContainerRoute.page,
  children: [
    AutoRoute(path: '', page: ArticlesRoute.page),
    AutoRoute(path: '${Routes.description}/:id', page: DetailsRoute.page),
  ],
);
