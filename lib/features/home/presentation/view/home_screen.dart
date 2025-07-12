import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/router/router_app.gr.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';
import 'package:flutter_test_tdd/features/home/presentation/view/widgets/home_provider.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeProvider(
      child: AutoTabsScaffold(
        appBarBuilder: (_, tabsRouter) => AppBar(toolbarHeight: 0),
        routes: [const DashboardRoute(), const ListingRoute()],
        floatingActionButton: FloatingActionButton(
          child: context.themeIsDark
              ? const Icon(Icons.light_mode)
              : const Icon(Icons.dark_mode),
          onPressed: () => context.themeNotifier.setTheme(
            context.themeIsDark ? ThemeMode.light : ThemeMode.dark,
          ),
        ),
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
