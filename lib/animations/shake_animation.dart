import 'dart:math';

import 'package:atomsbox/atomsbox.dart';
import 'package:flutter/material.dart';

class ShakeAnimationExample extends StatelessWidget {
  const ShakeAnimationExample({super.key});

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
        title: AppText.headlineSmall('Shake Animation'),
      ),
      body: Center(
        child: ShakeAnimationWrapper(
            child: Image.asset('assets/atomsbox.png', width: 300)),
      ),
    );
  }
}

class ShakeAnimationWrapper extends StatefulWidget {
  const ShakeAnimationWrapper({
    Key? key,
    this.delay = const Duration(milliseconds: 500),
    this.duration = const Duration(milliseconds: 2000),
    this.offset = const Offset(10.0, 0.0),
    this.shakes = 5.0,
    required this.child,
  }) : super(key: key);

  final Duration delay;
  final Duration duration;
  final Offset offset;
  final double shakes;
  final Widget child;

  @override
  State<ShakeAnimationWrapper> createState() => _ShakeAnimationWrapperState();
}

class _ShakeAnimationWrapperState extends State<ShakeAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

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
      builder: (context, child) {
        final sineValue = sin(
          widget.shakes * pi * animationController.value,
        );
        return Transform.translate(
          offset: Offset(
            sineValue * widget.offset.dx,
            0,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
