import 'package:flutter/material.dart';

class DelayAnimation extends StatefulWidget {
  const DelayAnimation({Key? key}) : super(key: key);

  @override
  State<DelayAnimation> createState() => _DelayAnimationState();
}

class _DelayAnimationState extends State<DelayAnimation>
    with SingleTickerProviderStateMixin {
  bool startAnimation = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1.5, 0.0),
    end: Offset.zero,
  ).animate(_controller);

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () => {
        setState(() {
          startAnimation = true;
        }),
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return startAnimation
        ? SlideTransition(
            position: _offsetAnimation,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: FlutterLogo(size: 150.0),
            ),
          )
        : Visibility(
            visible: false,
            child: Container(),
          );
  }
}
