import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_tdd/config/di/di.dart';
import 'package:flutter_test_tdd/features/listing/presentation/bloc/listing/listing_bloc.dart';
import 'package:flutter_test_tdd/features/listing/presentation/view/widgets/listing_view.dart';
import 'package:flutter_test_tdd/features/widgets/error_view.dart';
import 'package:flutter_test_tdd/features/widgets/loading_indicator.dart';
import 'package:flutter_test_tdd/features/widgets/refresh_container.dart';

@RoutePage()
class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  late final RefreshController _refreshController;
  late final ListingBloc _listingBloc;

  @override
  void initState() {
    _refreshController = RefreshController();
    _listingBloc = context.get<ListingBloc>()..add(GetListingEvent());
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
    return BlocConsumer<ListingBloc, ListingState>(
      bloc: _listingBloc,
      listener: _updateListener,
      builder: (context, state) => switch (state) {
        ListingInitialState() => LoadingIndicator(),
        ListingErrorState() => ErrorView(failure: state.failure),
        ListingSuccessState() => RefreshContainer(
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: ListingView(items: state.listing),
        ),
      },
    );
  }

  void _onRefresh() => _listingBloc.add(GetListingEvent());

  void _updateListener(BuildContext context, ListingState state) =>
      Future.delayed(
        Duration(seconds: 3), // for show animation
        () => _refreshController.stopLoading(),
      );
}
