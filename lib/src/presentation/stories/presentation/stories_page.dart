import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stories'),
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
