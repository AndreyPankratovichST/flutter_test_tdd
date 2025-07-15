import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
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
    return AnimatedSwitcher(
      duration: _duration,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: animation, child: child),
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) =>
            Transform.scale(scale: _animation.value, child: child),
        child: const _ColoredLoader(),
      ),
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
