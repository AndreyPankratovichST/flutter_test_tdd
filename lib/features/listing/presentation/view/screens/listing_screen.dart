import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_tdd/config/di/di.dart';
import 'package:flutter_test_tdd/features/listing/presentation/bloc/listing/listing_bloc.dart';
import 'package:flutter_test_tdd/features/listing/presentation/view/widgets/listing_view.dart';
import 'package:flutter_test_tdd/features/widgets/error_view.dart';
import 'package:flutter_test_tdd/features/widgets/loading_indicator.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  late final ListingBloc _listingBloc;

  @override
  void initState() {
    _listingBloc = getIt<ListingBloc>()..add(GetListingEvent());
    super.initState();
  }

  @override
  void dispose() {
    _listingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListingBloc, ListingState>(
      bloc: _listingBloc,
      builder: (context, state) => switch (state) {
        ListingInitialState() => LoadingIndicator(),
        ListingErrorState() => ErrorView(failure: state.failure),
        ListingSuccessState() => ListingView(items: state.listing),
      },
    );
  }
}
