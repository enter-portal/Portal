import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobileLayout,
    required this.desktopLayout,
  });

  final Widget mobileLayout;
  final Widget desktopLayout;

  @override
  Widget build(BuildContext context) {
    return ShadResponsiveBuilder(
      builder: (context, breakpoint) {
        final sm = breakpoint <= ShadTheme.of(context).breakpoints.md;
        if (sm) {
          return mobileLayout;
        } else {
          return desktopLayout;
        }
      },
    );
  }
}
