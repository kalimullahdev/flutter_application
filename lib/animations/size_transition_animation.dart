import 'package:flutter/material.dart';

class SizeTransitionAnimation extends StatefulWidget {
  const SizeTransitionAnimation({Key? key}) : super(key: key);

  @override
  State<SizeTransitionAnimation> createState() =>
      _SizeTransitionAnimationState();
}

class _SizeTransitionAnimationState extends State<SizeTransitionAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat().timeout(Duration(seconds: 2), onTimeout: () {
      _controller.forward(from: 44);
      _controller.stop(canceled: true);
    });
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceOut,
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      axis: Axis.horizontal,
      child: const Center(
        child: FlutterLogo(size: 100.0),
      ),
    );
  }
}
