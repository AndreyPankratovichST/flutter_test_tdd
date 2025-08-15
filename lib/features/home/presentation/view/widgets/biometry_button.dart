import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/router/router_app.gr.dart';

const _heroTag = 'biometry';

class BiometryButton extends StatelessWidget {
  const BiometryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: _heroTag,
      child: const Icon(Icons.fingerprint),
      onPressed: () => context.router.push(const BiometryRoute()),
    );
  }
}

