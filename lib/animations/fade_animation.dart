import 'package:atomsbox/atomsbox.dart';
import 'package:flutter/material.dart';

class FadeAnimationExample extends StatelessWidget {
  const FadeAnimationExample({super.key});

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
        title: AppText.headlineSmall('Fade Animation'),
      ),
      body: FadeAnimationWrapper(
        child: Center(child: Image.asset('assets/atomsbox.png', width: 300)),
      ),
    );
  }
}

class FadeAnimationWrapper extends StatefulWidget {
  const FadeAnimationWrapper({
    Key? key,
    this.duration = const Duration(milliseconds: 2000),
    this.delay = const Duration(milliseconds: 500),
    this.curve = const Interval(0, 1, curve: Curves.easeOut),
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
  State<FadeAnimationWrapper> createState() => _FadeAnimationWrapperState();
}

class _FadeAnimationWrapperState extends State<FadeAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> fadeAnimation;

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

    fadeAnimation = Tween<double>(
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
      builder: (context, child) => FadeTransition(
        opacity: fadeAnimation,
        child: child,
      ),
      child: widget.child,
    );
  }
}
