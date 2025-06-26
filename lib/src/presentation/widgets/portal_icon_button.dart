import 'package:flutter/material.dart';

class PortalIconButton extends StatelessWidget {
  const PortalIconButton({
    super.key,
    required this.icon,
    this.padding,
    this.onTap,
  });

  final Icon icon;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(padding: padding ?? EdgeInsets.zero, child: icon),
    );
  }
}
