import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/constants/constants.dart';
import 'package:flutter_test_tdd/config/localization/localization_app.dart';
import 'package:flutter_test_tdd/config/provider/app_group.dart';
import 'package:flutter_test_tdd/config/provider/init_provider.dart';
import 'package:flutter_test_tdd/config/router/router_app.dart';
import 'package:flutter_test_tdd/config/router/router_logger.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/features/common/error_view.dart';
import 'package:flutter_test_tdd/features/common/loading_indicator.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return InitProvider(
      loadingWidget: LoadingIndicator(),
      errorWidget: ErrorView(failure: PlatformFailure()),
      loadedWidget: MultiProvider(
        providers: appGroup,
        child: EasyLocalization(
          supportedLocales: supportLocales,
          fallbackLocale: defaultLocale,
          useFallbackTranslationsForEmptyResources: true,
          path: translationsPath,
          child: Consumer<ThemeNotifier>(
            builder: (context, notifier, _) {
              // Example for use custom deep link handler
              // return BlocListener<DeepLinkBloc, DeepLinkState>(
              //   listener: (context, state) {
              //     if (state is DeepLinkLoaded) {
              //       final path = state.url.fullPath;
              //       Logger.info('DEEPLINK PATH: $path');
              //       if (path.isNotEmpty) {
              //         context.read<AppRouter>().navigatePath(path);
              //       }
              //     }
              //   },
              //   child: MaterialApp.router(
              //     themeMode: notifier.themeMode,
              //     theme: lightTheme,
              //     darkTheme: darkTheme,
              //     routerConfig: context.read<AppRouter>().config(
              //       navigatorObservers: () => [RouterLogger()],
              //     ),
              //     localizationsDelegates: context.localizationDelegates,
              //     supportedLocales: context.supportedLocales,
              //     locale: context.locale,
              //   ),
              // );
              return MaterialApp.router(
                themeMode: notifier.themeMode,
                theme: lightTheme,
                darkTheme: darkTheme,
                routerConfig: context.read<AppRouter>().config(
                  navigatorObservers: () => [RouterLogger()],
                  deepLinkTransformer: DeepLink.prefixStripper(kAppScheme),
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
