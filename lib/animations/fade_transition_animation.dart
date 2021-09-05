import 'package:flutter/material.dart';

class FadeTransitionAnimation extends StatefulWidget {
  const FadeTransitionAnimation({Key? key}) : super(key: key);

  @override
  State<FadeTransitionAnimation> createState() =>
      _FadeTransitionAnimationState();
}

class _FadeTransitionAnimationState extends State<FadeTransitionAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat().timeout(const Duration(seconds: 2), onTimeout: () {
      _controller.forward(from: 22);
      _controller.stop(canceled: true);
    });
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: const Padding(
          padding: EdgeInsets.all(8),
          child: FlutterLogo(
            size: 100,
          )),
    );
  }
}
