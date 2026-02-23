import 'package:flutter/material.dart';
import 'package:portal/ui/core/ui/animations/bouncing_widget.dart';
import 'package:portal/ui/core/ui/animations/rotating_widget.dart';

class AnimatedWidgetWrapper extends StatelessWidget {
  final Widget child;
  final bool bouncing;
  final bool rotating;

  final double bounceHeight;
  final Duration bounceDuration;
  final Duration rotateDuration;

  const AnimatedWidgetWrapper({
    super.key,
    required this.child,
    this.bouncing = false,
    this.rotating = false,
    this.bounceHeight = 10.0,
    this.bounceDuration = const Duration(seconds: 2),
    this.rotateDuration = const Duration(seconds: 5),
  });

  @override
  Widget build(BuildContext context) {
    if (bouncing && rotating) {
      return BouncingWidget(
        height: bounceHeight,
        duration: bounceDuration,
        child: RotatingWidget(duration: rotateDuration, child: child),
      );
    } else if (bouncing) {
      return BouncingWidget(
        height: bounceHeight,
        duration: bounceDuration,
        child: child,
      );
    } else if (rotating) {
      return RotatingWidget(duration: rotateDuration, child: child);
    } else {
      return child;
    }
  }
}
