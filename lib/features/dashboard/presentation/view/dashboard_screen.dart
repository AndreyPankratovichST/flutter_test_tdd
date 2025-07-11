import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_tdd/features/dashboard/presentation/bloc/readable/readable_bloc.dart';
import 'package:flutter_test_tdd/features/dashboard/presentation/view/widgets/dashboard_view.dart';
import 'package:flutter_test_tdd/features/widgets/error_view.dart';
import 'package:flutter_test_tdd/features/widgets/loading_indicator.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadableBloc, ReadableState>(
      builder: (context, state) => switch (state) {
        ReadableInitialState() => LoadingIndicator(),
        ReadableErrorState() => ErrorView(failure: state.failure),
        ReadableSuccessState() => DashboardView(readable: state.readable),
      },
    );
  }
}
