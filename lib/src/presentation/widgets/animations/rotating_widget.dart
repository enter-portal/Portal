// Dart Imports
import 'dart:math' as math;

// Flutter Imports
import 'package:flutter/material.dart';

// A widget that continuously rotates its child
class RotatingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool autoStart;
  final Curve curve;
  final Alignment alignment;

  const RotatingWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.autoStart = true,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
  });

  @override
  State<RotatingWidget> createState() => RotatingWidgetState();
}

class RotatingWidgetState extends State<RotatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    if (widget.autoStart) {
      _controller.repeat();
    }
  }

  void startRotation() {
    _controller.repeat();
  }

  void stopRotation() {
    _controller.stop();
  }

  void resetRotation() {
    _controller.reset();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          alignment: widget.alignment,
          child: widget.child,
        );
      },
    );
  }
}
