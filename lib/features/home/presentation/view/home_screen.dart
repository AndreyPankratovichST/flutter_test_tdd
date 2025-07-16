import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/router/router_app.gr.dart';
import 'package:flutter_test_tdd/features/home/presentation/view/widgets/home_provider.dart';
import 'package:flutter_test_tdd/features/home/presentation/view/widgets/theme_change_button.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeProvider(
      child: AutoTabsScaffold(
        appBarBuilder: (_, tabsRouter) => AppBar(toolbarHeight: 0),
        routes: [ArticlesRoute()],
        floatingActionButton: ThemeChangeButton(),
      ),
    );
  }
}
