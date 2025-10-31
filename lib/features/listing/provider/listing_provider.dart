import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_tdd/features/listing/data/repository/listing_repository_impl.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_local_data_source.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_remote_data_source.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_articles.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_details.dart';
import 'package:flutter_test_tdd/features/listing/presentation/articles/bloc/articles/articles_bloc.dart';
import 'package:flutter_test_tdd/features/listing/presentation/details/bloc/details/details_bloc.dart';
import 'package:provider/provider.dart';

MultiProvider listingProvider = MultiProvider(
  providers: [
    Provider<ListingRemoteDataSource>(
      create: (context) => ApiListingRemoteDataSource(context.read()),
    ),
    Provider<ListingLocalDataSource>(
      create: (context) =>
          ListingLocalDataSourceImpl(sharedPreferences: context.read()),
    ),
    Provider<ListingRepository>(
      create: (context) => ListingRepositoryImpl(
        remoteDataSource: context.read(),
        localDataSource: context.read(),
        networkInfo: context.read(),
      ),
    ),

    Provider<GetArticlesUseCase>(
      create: (context) => GetArticlesUseCase(context.read()),
    ),
    BlocProvider<ArticlesBloc>(
      create: (context) => ArticlesBloc(context.read()),
    ),

    Provider<GetDetailsUseCase>(
      create: (context) => GetDetailsUseCase(context.read()),
    ),
    BlocProvider<DetailsBloc>(create: (context) => DetailsBloc(context.read())),
  ],
);
