import 'package:cherrypick/cherrypick.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/environment/environment.dart';
import 'package:flutter_test_tdd/core/client/client.dart';
import 'package:flutter_test_tdd/core/utils/network_info.dart';
import 'package:flutter_test_tdd/features/listing/listing_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'di_extension.dart';

part 'di_provider.dart';

Future<Scope> initDi(Environment env) async {
  final scope = openRootScope();
  final AppModule appModule = AppModule(env);
  await appModule.builder(scope);
  scope.installModules([appModule]);
  return scope;
}

final class AppModule extends Module {
  final Environment env;

  AppModule(this.env) : super();

  @override
  Future<void> builder(Scope currentScope) async {
    if (bindingSet.isNotEmpty) return;
    final sharedPreferences = await SharedPreferences.getInstance();
    bind<SharedPreferences>().toInstance(sharedPreferences);
    bind<NetworkInfo>().toInstance(NetworkInfoImpl(Connectivity()));
    bind<Environment>().toInstance(env);
    bind<AppClient>().toInstance(AppClient(env));
  }
}

final homeModules = [ListingModule()];