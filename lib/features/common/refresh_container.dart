import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/features/common/loading_animation.dart';

class RefreshController extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void startLoading() {
    if (!_isLoading) {
      _isLoading = true;
      notifyListeners();
    }
  }

  void stopLoading() {
    if (_isLoading) {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class RefreshContainer extends StatefulWidget {
  final Widget child;
  final VoidCallback onRefresh;
  final RefreshController controller;

  const RefreshContainer({
    super.key,
    required this.child,
    required this.onRefresh,
    required this.controller,
  });

  @override
  State<RefreshContainer> createState() => _RefreshContainerState();
}

class _RefreshContainerState extends State<RefreshContainer>
    with SingleTickerProviderStateMixin {
  late RefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  Future<void> _handleRefresh() async {
    _controller.startLoading();
    widget.onRefresh.call();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RefreshIndicator(onRefresh: _handleRefresh, child: widget.child),
        ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            final isLoading = _controller.isLoading;
            return isLoading
                ? Align(
                    alignment: Alignment.topCenter,
                    child: LoadingAnimation(),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
