import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calls'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
          '⚠️ Work in progress',
          style: ShadTheme.of(context).textTheme.h4,
        ),
      ),
    );
  }
}
