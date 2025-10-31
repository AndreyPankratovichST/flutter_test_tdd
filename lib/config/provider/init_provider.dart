import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitProvider extends StatelessWidget {
  const InitProvider({
    super.key,
    required this.loadingWidget,
    required this.loadedWidget,
    required this.errorWidget,
  });

  final Widget loadingWidget;
  final Widget loadedWidget;
  final Widget errorWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([SharedPreferences.getInstance()]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget;
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return errorWidget;
          } else {
            final results = snapshot.data!;
            final providers = results.map((e) => Provider.value(value: e))
                .toList();
            return MultiProvider(providers: providers, child: loadedWidget);
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
