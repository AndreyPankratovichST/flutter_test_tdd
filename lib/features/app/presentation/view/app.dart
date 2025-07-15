import 'package:cherrypick/cherrypick.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/di/di.dart';
import 'package:flutter_test_tdd/config/localization/localization_app.dart';
import 'package:flutter_test_tdd/config/router/router_app.dart';
import 'package:flutter_test_tdd/config/router/router_logger.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final Scope scope;

  const App({super.key, required this.scope});

  @override
  Widget build(BuildContext context) {
    return CherryPickProvider(
      scope: scope,
      child: EasyLocalization(
        supportedLocales: supportLocales,
        fallbackLocale: defaultLocale,
        useFallbackTranslationsForEmptyResources: true,
        path: translationsPath,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<AppRouter>(create: (_) => AppRouter()),
            ChangeNotifierProvider<ThemeNotifier>(
              create: (_) => ThemeNotifier(ThemeMode.system),
            ),
          ],
          child: Consumer<ThemeNotifier>(
            builder: (context, notifier, _) {
              return MaterialApp.router(
                themeMode: notifier.themeMode,
                theme: lightTheme,
                darkTheme: darkTheme,
                routerConfig: context.read<AppRouter>().config(
                  navigatorObservers: () => [RouterLogger()],
                ),
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
              );
            },
          ),
        ),
      ),
    );
  }
}
