import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/src/app/app.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}
