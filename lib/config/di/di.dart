import 'package:cherrypick/cherrypick.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/environment/environment.dart';
import 'package:flutter_test_tdd/core/client/client.dart';
import 'package:flutter_test_tdd/core/utils/network_info.dart';
import 'package:flutter_test_tdd/features/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/usecase/get_readable.dart';
import 'package:flutter_test_tdd/features/dashboard/presentation/bloc/readable/readable_bloc.dart';
import 'package:flutter_test_tdd/features/listing/data/repository/listing_repository_impl.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_local_data_source.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_remote_data_source.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_description.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_listing.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/save_list_item.dart';
import 'package:flutter_test_tdd/features/listing/presentation/bloc/description/description_bloc.dart';
import 'package:flutter_test_tdd/features/listing/presentation/bloc/listing/listing_bloc.dart';
import 'package:flutter_test_tdd/features/listing/presentation/bloc/reading/reading_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'di_extension.dart';
part 'di_provider.dart';

Future<Scope> initDi(Environment env) async {
  final scope = openRootScope().installModules([AppModule(env)]);
  return scope;
}

final class AppModule extends Module {
  final Environment env;

  AppModule(this.env) : super();

  @override
  Future<void> builder(Scope currentScope) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bind<SharedPreferences>().toInstance(sharedPreferences);
    bind<NetworkInfo>().toInstance(NetworkInfoImpl(Connectivity()));
    bind<Environment>().toInstance(env);
    bind<AppClient>().toInstance(AppClient(env));
  }
}

final class DashboardModule extends Module {
  static const String name = "Dashboard";

  @override
  void builder(Scope currentScope) {
    bind<ListingLocalDataSource>().toProvide(
      () => ListingLocalDataSourceImpl(
        sharedPreferences: currentScope.resolve<SharedPreferences>(),
      ),
    );
    bind<DashboardRepository>().toProvide(
      () =>
          DashboardReadableImpl(currentScope.resolve<ListingLocalDataSource>()),
    );
    bind<GetReadableUseCase>().toProvide(
      () => GetReadableUseCase(currentScope.resolve<DashboardRepository>()),
    );
    bind<ReadableBloc>().toProvide(
      () => ReadableBloc(currentScope.resolve<GetReadableUseCase>()),
    );
  }
}

final class ListingModule extends Module {
  static const String name = "Listing";

  @override
  void builder(Scope currentScope) {
    bind<ListingRemoteDataSource>().toProvide(
      () => ListingRemoteDataSourceImpl(dio: currentScope.resolve<AppClient>()),
    );
    bind<ListingLocalDataSource>().toProvide(
      () => ListingLocalDataSourceImpl(
        sharedPreferences: currentScope.resolve<SharedPreferences>(),
      ),
    );
    bind<ListingRepository>().toProvide(
      () => ListingRepositoryImpl(
        remoteDataSource: currentScope.resolve<ListingRemoteDataSource>(),
        localDataSource: currentScope.resolve<ListingLocalDataSource>(),
        networkInfo: currentScope.resolve<NetworkInfo>(),
      ),
    );
    bind<GetListingUseCase>().toProvide(
      () => GetListingUseCase(currentScope.resolve<ListingRepository>()),
    );
    bind<ListingBloc>().toProvide(
      () => ListingBloc(currentScope.resolve<GetListingUseCase>()),
    );
    bind<GetDescriptionUseCase>().toProvide(
      () => GetDescriptionUseCase(currentScope.resolve<ListingRepository>()),
    );
    bind<DescriptionBloc>().toProvide(
      () => DescriptionBloc(currentScope.resolve<GetDescriptionUseCase>()),
    );
    bind<SaveListItemUseCase>().toProvide(
      () => SaveListItemUseCase(currentScope.resolve<ListingRepository>()),
    );
    bind<ReadingBloc>().toProvide(
      () => ReadingBloc(currentScope.resolve<SaveListItemUseCase>()),
    );
  }
}
