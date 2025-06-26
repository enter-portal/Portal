import 'package:flutter/material.dart';
import 'package:portal/src/presentation/widgets/portal_icon_button.dart';
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
      leading: const PortalIconButton(icon: Icon(LucideIcons.lock)),
      trailing: PortalIconButton(
        icon: Icon(
          obscure.value ? LucideIcons.eyeOff : LucideIcons.eye,
          size: 25,
        ),
        onTap: () {
          obscure.value = !obscure.value;
        },
      ),
    );
  }
}
