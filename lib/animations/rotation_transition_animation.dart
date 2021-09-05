import 'package:flutter/material.dart';

class RotationTransitionAnimation extends StatefulWidget {
  const RotationTransitionAnimation({Key? key}) : super(key: key);

  @override
  State<RotationTransitionAnimation> createState() =>
      _RotationTransitionAnimationState();
}

class _RotationTransitionAnimationState
    extends State<RotationTransitionAnimation> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat().timeout(const Duration(seconds: 2), onTimeout: () {
      _controller.forward(from: 0);
      _controller.stop(canceled: true);
    });
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _animation,
        child: const FlutterLogo(
          size: 100,
        ),
      ),
    );
  }
}
