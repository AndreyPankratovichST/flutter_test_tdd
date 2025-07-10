import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_tdd/config/di/di.dart';
import 'package:flutter_test_tdd/features/listing/presentation/bloc/description/description_bloc.dart';
import 'package:flutter_test_tdd/features/listing/presentation/view/widgets/description_view.dart';
import 'package:flutter_test_tdd/features/widgets/apps_bar.dart';
import 'package:flutter_test_tdd/features/widgets/error_view.dart';
import 'package:flutter_test_tdd/features/widgets/loading_indicator.dart';
import 'package:go_router/go_router.dart';

class DescriptionScreen extends StatefulWidget {
  final int id;

  const DescriptionScreen({super.key, required this.id});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  late final DescriptionBloc _descriptionBloc;

  @override
  void initState() {
    _descriptionBloc = getIt<DescriptionBloc>()
      ..add(GetDescriptionEvent(widget.id));
    super.initState();
  }

  @override
  void dispose() {
    _descriptionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.viewPaddingOf(context).top),
        AppsBar(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<DescriptionBloc, DescriptionState>(
            bloc: _descriptionBloc,
            builder: (context, state) => switch (state) {
              DescriptionInitialState() => LoadingIndicator(),
              DescriptionErrorState() => ErrorView(failure: state.failure),
              DescriptionSuccessState() => DescriptionView(
                description: state.description,
              ),
            },
          ),
        ),
      ],
    );
  }
}
