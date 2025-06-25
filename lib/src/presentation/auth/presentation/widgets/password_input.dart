import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart'; // Required for useState
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'; // Required for HookConsumerWidget

class PasswordInput extends HookConsumerWidget {
  const PasswordInput({
    super.key,
    required this.id,
    this.label,
    this.placeholder,
  });

  final String id;
  final Widget? label;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscure = useState(true);

    return ShadInputFormField(
      id: id, // Accessing properties directly since it's a HookConsumerWidget
      label: label,
      placeholder: placeholder,
      obscureText: obscure.value, // Use the value from the useState hook
      leading: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Icon(LucideIcons.lock),
      ),
      trailing: ShadButton(
        width: 24,
        height: 24,
        padding: EdgeInsets.zero,
        // Conditionally display the eye icon based on the 'obscure' state.
        child: Icon(obscure.value ? LucideIcons.eyeOff : LucideIcons.eye),
        onPressed: () {
          // Toggle the 'obscure' state when the button is pressed.
          obscure.value = !obscure.value;
        },
      ),
    );
  }
}
