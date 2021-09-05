import 'package:flutter/material.dart';

class ScaleTransitionAnimation extends StatefulWidget {
  const ScaleTransitionAnimation({Key? key}) : super(key: key);

  @override
  State<ScaleTransitionAnimation> createState() =>
      _ScaleTransitionAnimationState();
}

class _ScaleTransitionAnimationState extends State<ScaleTransitionAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _scaleTransitionController =
      AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat().timeout(
          const Duration(seconds: 2),
          onTimeout: () {
            _scaleTransitionController.forward(from: 50);
            _scaleTransitionController.stop();
          },
        );
  late final Animation<double> _scaleTransitionAnimation = CurvedAnimation(
    parent: _scaleTransitionController,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    super.dispose();
    _scaleTransitionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleTransitionAnimation,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: FlutterLogo(size: 150.0),
      ),
    );
  }
}
