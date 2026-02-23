import 'package:flutter/material.dart';
import 'package:portal/config/app_configs.dart';
import 'package:portal/ui/core/ui/animations/animate_widget.dart';
import 'package:portal/ui/core/ui/portal_logo.dart';

class PortalAnimatedLogo extends StatelessWidget {
  final double dimension;
  final double bounceHeight;
  final bool bouncing;
  final bool rotating;
  static const String assetName = AppConfigs.appLogo;

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
