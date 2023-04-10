import 'package:atomsbox/atomsbox.dart';
import 'package:flutter/material.dart';

class RotateAnimationExample extends StatelessWidget {
  const RotateAnimationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppIconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        title: AppText.headlineSmall('Rotate Animation'),
      ),
      body: Center(
        child: RotateAnimationWrapper(
            child: Image.asset('assets/atomsbox.png', width: 300)),
      ),
    );
  }
}

class RotateAnimationWrapper extends StatefulWidget {
  const RotateAnimationWrapper({
    Key? key,
    this.duration = const Duration(milliseconds: 2000),
    this.delay = const Duration(milliseconds: 500),
    this.curve = const Interval(0, 1, curve: Curves.easeInOutExpo),
    this.begin = 0.0,
    this.end = 1.0,
    required this.child,
  }) : super(key: key);

  final Duration delay;
  final Duration duration;
  final Curve curve;
  final double begin;
  final double end;
  final Widget child;

  @override
  State<RotateAnimationWrapper> createState() => _RotateAnimationWrapperState();
}

class _RotateAnimationWrapperState extends State<RotateAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> rotateAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    Future.delayed(
      widget.delay,
      () {
        if (!mounted) return;
        animationController.forward();
      },
    );

    rotateAnimation = Tween<double>(
      begin: widget.begin,
      end: widget.end,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: widget.curve,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => Transform.rotate(
        angle: rotateAnimation.value * 2 * 3.14,
        child: child,
      ),
      child: widget.child,
    );
  }
}
