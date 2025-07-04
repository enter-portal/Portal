import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class PortalLogo extends StatelessWidget {
  final Color primary;

  const PortalLogo({super.key, required this.primary});

  @override
  Widget build(BuildContext context) {
    // Add this CustomPaint widget to the widget tree
    return CustomPaint(painter: _RPSCustomPainter(primaryColor: primary));
  }
}

// SVG to CustomPainter: https://fluttershapemaker.com/#/
class _RPSCustomPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor = Color(0xffF6D2B7);
  final Color tertiaryColor = Color(0xff102E4A);

  _RPSCustomPainter({required this.primaryColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.01000000;

    paint0Stroke.shader = ui.Gradient.radial(
      Offset(size.width * 0.5000000, size.height * 0.5000000),
      size.width * 0.5000000,
      [tertiaryColor.withAlpha(204), secondaryColor.withAlpha(0)],
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
      [secondaryColor.withAlpha(255), tertiaryColor.withAlpha(255)],
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
      [secondaryColor.withAlpha(255), tertiaryColor.withAlpha(255)],
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
        secondaryColor.withAlpha(255),
        primaryColor.withAlpha(255),
        tertiaryColor.withAlpha(255),
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
