import 'package:cherrypick/cherrypick.dart';
import 'package:flutter_test_tdd/core/client/client.dart';
import 'package:flutter_test_tdd/core/utils/network_info.dart';
import 'package:flutter_test_tdd/features/listing/data/repository/listing_repository_impl.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_local_data_source.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_remote_data_source.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_details.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_articles.dart';
import 'package:flutter_test_tdd/features/listing/presentation/articles/bloc/articles/articles_bloc.dart';
import 'package:flutter_test_tdd/features/listing/presentation/details/bloc/details/details_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class ListingModule extends Module {
  @override
  void builder(Scope currentScope) {
    bind<ListingRemoteDataSource>().toProvide(
      () => ApiListingRemoteDataSource(currentScope.resolve<AppClient>()),
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
    bind<GetArticlesUseCase>().toProvide(
      () => GetArticlesUseCase(currentScope.resolve<ListingRepository>()),
    );
    bind<ArticlesBloc>().toProvide(
      () => ArticlesBloc(currentScope.resolve<GetArticlesUseCase>()),
    );
    bind<GetDetailsUseCase>().toProvide(
      () => GetDetailsUseCase(currentScope.resolve<ListingRepository>()),
    );
    bind<DetailsBloc>().toProvide(
      () => DetailsBloc(currentScope.resolve<GetDetailsUseCase>()),
    );
  }
}
