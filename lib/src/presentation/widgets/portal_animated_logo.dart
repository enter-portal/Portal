// Flutter Imports
import 'package:flutter/material.dart';

// Package Imports
import 'package:portal/src/app/config/constants.dart';
import 'package:portal/src/presentation/widgets/animations/animate_widget.dart';
import 'package:portal/src/presentation/widgets/portal_logo.dart';

class PortalAnimatedLogo extends StatelessWidget {
  final double dimension;
  final double bounceHeight;
  final bool bouncing;
  final bool rotating;
  static const String assetName = AppConstants.appLogo;

  const PortalAnimatedLogo({
    super.key,
    this.dimension = 0,
    this.bouncing = true,
    this.rotating = true,
    this.bounceHeight = 30,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgetWrapper(
      bounceHeight: bounceHeight,
      bounceDuration: const Duration(seconds: 2),
      rotateDuration: const Duration(seconds: 5),
      bouncing: bouncing,
      rotating: rotating,
      child: SizedBox.square(
        dimension: dimension,
        child: PortalLogo(primary: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}