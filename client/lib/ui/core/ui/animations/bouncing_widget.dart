import 'package:flutter/material.dart';

class BouncingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double height;
  final bool autoStart;
  final Curve curve;

  const BouncingWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.height = 10.0,
    this.autoStart = true,
    this.curve = Curves.easeInOut,
  });

  @override
  State<BouncingWidget> createState() => BouncingWidgetState();
}

class BouncingWidgetState extends State<BouncingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.height,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    if (widget.autoStart) {
      _controller.repeat(reverse: true);
    }
  }

  void startBouncing() {
    _controller.repeat(reverse: true);
  }

  void stopBouncing() {
    _controller.stop();
  }

  void resetBouncing() {
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
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_animation.value),
          child: widget.child,
        );
      },
    );
  }
}
