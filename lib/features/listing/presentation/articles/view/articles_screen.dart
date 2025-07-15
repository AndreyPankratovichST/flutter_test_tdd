import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_tdd/config/di/di.dart';
import 'package:flutter_test_tdd/features/common/refresh_container.dart';
import 'package:flutter_test_tdd/features/common/error_view.dart';
import 'package:flutter_test_tdd/features/common/loading_indicator.dart';
import 'package:flutter_test_tdd/features/listing/presentation/articles/bloc/articles/articles_bloc.dart';
import 'package:flutter_test_tdd/features/listing/presentation/widgets/articles_view.dart';

@RoutePage()
class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  late final RefreshController _refreshController;
  late final ArticlesBloc _listingBloc;

  @override
  void initState() {
    _refreshController = RefreshController();
    _listingBloc = context.get<ArticlesBloc>()..add(GetArticlesEvent());
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _listingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticlesBloc, ArticlesState>(
      bloc: _listingBloc,
      listener: _updateListener,
      builder: (context, state) => switch (state) {
        ArticlesInitialState() => LoadingIndicator(),
        ArticlesErrorState() => ErrorView(failure: state.failure),
        ArticlesSuccessState() => RefreshContainer(
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: ArticlesView(items: state.listing),
        ),
      },
    );
  }

  void _onRefresh() => _listingBloc.add(GetArticlesEvent());

  void _updateListener(BuildContext context, ArticlesState state) =>
      switch (state) {
        ArticlesSuccessState() => _stopLoadingAnimation(),
        ArticlesErrorState() => _stopLoadingAnimation(),
        _ => null,
      };

  void _stopLoadingAnimation() => Future.delayed(
    Duration(seconds: 3), // for show animation
    () => _refreshController.stopLoading(),
  );
}
