import 'package:cherrypick/cherrypick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_tdd/config/di/di.dart';
import 'package:flutter_test_tdd/features/dashboard/presentation/bloc/readable/readable_bloc.dart';

const String scopeName = 'home';

class HomeProvider extends StatefulWidget {
  final Widget child;

  const HomeProvider({super.key, required this.child});

  @override
  State<HomeProvider> createState() => _HomeProviderState();
}

class _HomeProviderState extends State<HomeProvider> {
  late final Scope _scope;

  @override
  void initState() {
    _scope = context.scope.openSubScope(scopeName);
    _scope.installModules([DashboardModule(), ListingModule()]);
    super.initState();
  }

  @override
  void dispose() {
    _scope.parentScope?.closeSubScope(scopeName);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CherryPickProvider(
      scope: _scope,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => context.get<ReadableBloc>()..add(GetReadableEvent()),
          ),
        ],
        child: widget.child,
      ),
    );
  }
}
