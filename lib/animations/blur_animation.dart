import 'dart:ui';

import 'package:atomsbox/atomsbox.dart';
import 'package:flutter/material.dart';

class BlurAnimationExample extends StatelessWidget {
  const BlurAnimationExample({super.key});

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
        title: AppText.headlineSmall('Blur Animation'),
      ),
      body: BlurAnimationWrapper(
        child: Center(child: Image.asset('assets/atomsbox.png', width: 300)),
      ),
    );
  }
}

class BlurAnimationWrapper extends StatefulWidget {
  const BlurAnimationWrapper({
    Key? key,
    this.duration = const Duration(milliseconds: 2000),
    this.delay = const Duration(milliseconds: 500),
    this.curve = const Interval(0, 1, curve: Curves.easeInBack),
    this.initialOffset = const Offset(4.0, 4.0),
    this.finalOffset = const Offset(0.0, 0.0),
    required this.child,
  }) : super(key: key);

  final Duration delay;
  final Duration duration;
  final Curve curve;
  final Offset initialOffset;
  final Offset finalOffset;
  final Widget child;

  @override
  State<BlurAnimationWrapper> createState() => _BlurAnimationWrapperState();
}

class _BlurAnimationWrapperState extends State<BlurAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Offset> blurAnimation;

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

    blurAnimation = Tween<Offset>(
      begin: widget.initialOffset,
      end: widget.finalOffset,
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
      builder: (context, child) {
        final double sigmaX = blurAnimation.value.dx;
        final double sigmaY = blurAnimation.value.dy;

        return ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: sigmaX,
            sigmaY: sigmaY,
            tileMode: TileMode.decal,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
