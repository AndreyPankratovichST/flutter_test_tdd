import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_tdd/config/environment/environment.dart';
import 'package:flutter_test_tdd/config/environment/environment_app.dart';
import 'package:flutter_test_tdd/config/router/router_app.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';
import 'package:flutter_test_tdd/core/client/client.dart';
import 'package:flutter_test_tdd/core/utils/network_info.dart';
import 'package:flutter_test_tdd/features/app/data/repository/deep_link_repository_impl.dart';
import 'package:flutter_test_tdd/features/app/data/source/deep_link_platform_source.dart';
import 'package:flutter_test_tdd/features/app/domain/repository/deep_link_repository.dart';
import 'package:flutter_test_tdd/features/app/domain/usecase/get_deeplink_stream.dart';
import 'package:flutter_test_tdd/features/app/domain/usecase/get_init_deeplink.dart';
import 'package:flutter_test_tdd/features/app/presentation/bloc/deeplink/deeplink_bloc.dart';
import 'package:provider/provider.dart';

MultiProvider appProvider = MultiProvider(
  providers: [
    Provider<Environment>(create: (_) => initEnv()),

    Provider<Connectivity>(create: (_) => Connectivity()),
    Provider<NetworkInfo>(create: (context) => NetworkInfoImpl(context.read())),
    RepositoryProvider<AppClient>(
      create: (context) => AppClient(context.read()),
      dispose: (value) => value.dispose(),
    ),

    Provider<DeepLinkPlatformSource>(
      create: (_) => DeepLinkPlatformSourceImpl(),
    ),
    Provider<DeepLinkRepository>(
      create: (context) => DeepLinkRepositoryImpl(context.read()),
    ),
    Provider<GetInitDeeplinkUseCase>(
      create: (context) => GetInitDeeplinkUseCase(context.read()),
    ),
    Provider<GetDeepLinkStreamUseCase>(
      create: (context) => GetDeepLinkStreamUseCase(context.read()),
    ),
    // Example for use custom deep link handler
    BlocProvider<DeepLinkBloc>(
      create: (context) => DeepLinkBloc(context.read(), context.read()),
    ),

    ChangeNotifierProvider<AppRouter>(create: (_) => AppRouter()),
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(ThemeMode.system),
    ),
  ],
);
