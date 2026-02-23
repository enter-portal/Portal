import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PasswordInput extends HookConsumerWidget {
  const PasswordInput({
    super.key,
    required this.id,
    this.label,
    this.placeholder,
    this.validator,
    this.controller,
  });

  final String id;
  final Widget? label;
  final Widget? placeholder;
  final String? Function(String)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscure = useState(true);

    return ShadInputFormField(
      id: id,
      controller: controller,
      label: label,
      placeholder: placeholder,
      obscureText: obscure.value,
      validator:
          validator ??
          (v) => v.length < 6 ? 'Password must be at least 6 characters' : null,
      leading: const Padding(
        padding: EdgeInsets.all(5.0),
        child: Icon(LucideIcons.lock, size: 18),
      ),
      trailing: ShadButton.ghost(
        height: 0,
        width: 0,
        padding: EdgeInsets.all(5.0),
        child: Icon(
          obscure.value ? LucideIcons.eyeOff : LucideIcons.eye,
          size: 18,
        ),
        onPressed: () {
          obscure.value = !obscure.value;
        },
      ),
    );
  }
}
