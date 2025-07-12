import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/router/router_app.gr.dart';
import 'package:flutter_test_tdd/features/home/presentation/view/widgets/home_provider.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeProvider(
      child: AutoTabsScaffold(
        appBarBuilder: (_, tabsRouter) => AppBar(toolbarHeight: 0),
        routes: [
          const DashboardRoute(),
          const ListingRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.dashboard_outlined),
                label: 'home.dashboard'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.format_list_bulleted_rounded),
                label: 'home.listing'.tr(),
              ),
            ],
          );
        },
      ),
    );
  }
}
