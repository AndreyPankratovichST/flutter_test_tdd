import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/features/home/presentation/view/widgets/home_provider.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return HomeProvider(
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: shell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: shell.currentIndex,
          onTap: (index) => _onTap(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) {
    if (index != shell.currentIndex) {
      shell.goBranch(index);
    }
  }
}
