import 'dart:io';

import 'package:flutter/material.dart';

class ResponsiveSpacer extends StatelessWidget {
  const ResponsiveSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS || Platform.isAndroid
        ? Expanded(child: SizedBox())
        : const SizedBox(height: 20);
  }
}
