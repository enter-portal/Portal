import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveSpacer extends StatelessWidget {
  const ResponsiveSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile =
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;
    final isNarrowWeb = kIsWeb && MediaQuery.of(context).size.width < 700;

    return (isMobile || isNarrowWeb)
        ? const Expanded(child: SizedBox())
        : const SizedBox(height: 20);
  }
}
