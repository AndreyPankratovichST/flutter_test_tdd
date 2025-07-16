import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_tdd/config/di/di.dart';
import 'package:flutter_test_tdd/features/common/error_view.dart';
import 'package:flutter_test_tdd/features/common/loading_indicator.dart';
import 'package:flutter_test_tdd/features/listing/presentation/details/bloc/details/details_bloc.dart';
import 'package:flutter_test_tdd/features/listing/presentation/widgets/description_view.dart';

@RoutePage()
class DetailsScreen extends StatefulWidget {
  final int id;
  final String? title;

  const DetailsScreen({
    super.key,
    @pathParam required this.id,
    @queryParam this.title,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final DetailsBloc _descriptionBloc;

  @override
  void initState() {
    _descriptionBloc = context.get<DetailsBloc>()
      ..add(GetDetailsEvent(widget.id));
    super.initState();
  }

  @override
  void dispose() {
    _descriptionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: AutoLeadingButton(), title: Text(widget.title ?? ''),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<DetailsBloc, DetailsState>(
          bloc: _descriptionBloc,
          builder: (context, state) => switch (state) {
            DetailsInitialState() => LoadingIndicator(),
            DetailsErrorState() => ErrorView(failure: state.failure),
            DetailsSuccessState() => DescriptionView(
              description: state.details,
            ),
          },
        ),
      ),
    );
  }
}
