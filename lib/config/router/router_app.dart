import 'package:flutter_test_tdd/config/router/routes.dart';
import 'package:flutter_test_tdd/core/extensions/string.dart';
import 'package:flutter_test_tdd/features/dashboard/presentation/view/dashboard_screen.dart';
import 'package:flutter_test_tdd/features/home/presentation/view/home_screen.dart';
import 'package:flutter_test_tdd/features/listing/presentation/view/screens/description_screen.dart';
import 'package:flutter_test_tdd/features/listing/presentation/view/screens/listing_screen.dart';
import 'package:go_router/go_router.dart';

final class AppRouter {
  final router = GoRouter(
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => HomeScreen(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.dashboard,
                path: '/',
                builder: (_, __) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.listing,
                path: '/${Routes.listing}',
                builder: (_, _) => const ListingScreen(),
                routes: [
                  GoRoute(
                    name: Routes.details,
                    path: '${Routes.details}/:id',
                    builder: (_, state) {
                      final id = state.pathParameters['id'].toInt;
                      if (id == null) throw Exception('Invalid id');
                      return DescriptionScreen(id: id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
