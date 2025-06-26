import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:portal/src/app/config/constants.dart';

class PortalLogo extends StatelessWidget {
  final Color primary;
  final Color secondary;
  final Color tertiary;

  const PortalLogo({
    super.key,
    this.primary = AppConstants.primary,
    this.secondary = AppConstants.secondary,
    this.tertiary = AppConstants.tertiary,
  });

  @override
  Widget build(BuildContext context) {
    // Add this CustomPaint widget to the widget tree
    return CustomPaint(
      painter: _RPSCustomPainter(
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
      ),
    );
  }
}

// SVG to CustomPainter: https://fluttershapemaker.com/#/
class _RPSCustomPainter extends CustomPainter {
  final Color primary;
  final Color secondary;
  final Color tertiary;

  _RPSCustomPainter({
    this.primary = AppConstants.primary,
    this.secondary = AppConstants.secondary,
    this.tertiary = AppConstants.tertiary,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.01000000;
    paint0Stroke.shader = ui.Gradient.radial(
      Offset(size.width * 0.5000000, size.height * 0.5000000),
      size.width * 0.5000000,
      [primary.withAlpha((0.8 * 255).round()), secondary.withAlpha(0)],
      [0, 1],
    );
    canvas.drawCircle(
      Offset(size.width * 0.5000000, size.height * 0.5000000),
      size.width * 0.3100000,
      paint0Stroke,
    );

    Paint paint1Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.003000000;
    paint1Stroke.shader = ui.Gradient.linear(
      Offset(0, 0),
      Offset(size.width, size.height),
      [secondary.withAlpha(255), primary.withAlpha(255)],
      [0, 1],
    );
    canvas.drawCircle(
      Offset(size.width * 0.5000000, size.height * 0.5000000),
      size.width * 0.3500000,
      paint1Stroke,
    );

    Paint paint2Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.002000000;
    paint2Stroke.shader = ui.Gradient.linear(
      Offset(0, 0),
      Offset(size.width, size.height),
      [secondary.withAlpha(255), primary.withAlpha(255)],
      [0, 1],
    );
    canvas.drawCircle(
      Offset(size.width * 0.5000000, size.height * 0.5000000),
      size.width * 0.3300000,
      paint2Stroke,
    );

    Paint paint3Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.08000000;
    paint3Stroke.shader = ui.Gradient.linear(
      Offset(0, 0),
      Offset(size.width, size.height),
      [
        secondary.withAlpha(255),
        tertiary.withAlpha(255),
        primary.withAlpha(255),
      ],
      [0, 0.5, 1],
    );
    canvas.drawCircle(
      Offset(size.width * 0.5000000, size.height * 0.5000000),
      size.width * 0.2800000,
      paint3Stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
