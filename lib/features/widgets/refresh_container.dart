import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';

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
  final _fadeDuration = const Duration(milliseconds: 500);
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
            return Align(
              alignment: Alignment.topCenter,
              child: AnimatedSwitcher(
                duration: _fadeDuration,
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                ),
                child: isLoading
                    ? _LoadingAnimation()
                    : const SizedBox.shrink(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _LoadingAnimation extends StatefulWidget {
  const _LoadingAnimation();

  @override
  State<_LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<_LoadingAnimation>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 400);
  static const double _lowerBound = 0.5;
  static const double _upperBound = 1.0;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
      lowerBound: _lowerBound,
      upperBound: _upperBound,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInQuart,
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) =>
          Transform.scale(scale: _animation.value, child: child),
      child: const _ColoredLoader(),
    );
  }
}

class _ColoredLoader extends StatelessWidget {
  const _ColoredLoader();

  static const double _dimension = 80.0;
  static const double _radius = 0.85;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [Colors.white, context.theme.primaryColor],
          radius: _radius,
        ),
      ),
      child: const SizedBox.square(dimension: _dimension),
    );
  }
}
