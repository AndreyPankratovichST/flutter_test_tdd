import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_tdd/config/di/di.dart';
import 'package:flutter_test_tdd/features/dashboard/presentation/bloc/readable/readable_bloc.dart';
import 'package:flutter_test_tdd/features/listing/presentation/bloc/description/description_bloc.dart';
import 'package:flutter_test_tdd/features/listing/presentation/bloc/reading/reading_bloc.dart';
import 'package:flutter_test_tdd/features/listing/presentation/view/widgets/description_view.dart';
import 'package:flutter_test_tdd/features/widgets/error_view.dart';
import 'package:flutter_test_tdd/features/widgets/loading_indicator.dart';

@RoutePage()
class DescriptionScreen extends StatefulWidget {
  final int id;

  const DescriptionScreen({super.key, required this.id});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  late final DescriptionBloc _descriptionBloc;
  late final ReadingBloc _readingBloc;

  @override
  void initState() {
    _descriptionBloc = context.get<DescriptionBloc>()
      ..add(GetDescriptionEvent(widget.id));
    _readingBloc = context.get<ReadingBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionBloc.close();
    _readingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: AutoLeadingButton()),
      body: BlocListener<ReadingBloc, ReadingState>(
        bloc: _readingBloc,
        listener: _saveToReadableListener,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<DescriptionBloc, DescriptionState>(
            bloc: _descriptionBloc,
            listener: _successLoadingListener,
            builder: (context, state) => switch (state) {
              DescriptionInitialState() => LoadingIndicator(),
              DescriptionErrorState() => ErrorView(failure: state.failure),
              DescriptionSuccessState() => DescriptionView(
                description: state.description,
              ),
            },
          ),
        ),
      ),
    );
  }

  void _successLoadingListener(BuildContext context, DescriptionState state) =>
      switch (state) {
        DescriptionSuccessState() => _readingBloc.add(
          SaveReadEvent(state.description),
        ),
        _ => null,
      };

  void _saveToReadableListener(BuildContext context, ReadingState state) =>
      switch (state) {
        ReadingSuccessOperationState() => BlocProvider.of<ReadableBloc>(
          context,
        ).add(GetReadableEvent()),
        _ => null,
      };
}
