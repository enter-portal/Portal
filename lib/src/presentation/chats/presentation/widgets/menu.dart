import 'package:flutter/material.dart';
import 'package:portal/src/presentation/auth/presentation/landing_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PopoverMenu extends StatefulWidget {
  const PopoverMenu({super.key});

  @override
  State<PopoverMenu> createState() => _PopoverMenuState();
}

class _PopoverMenuState extends State<PopoverMenu> {
  final popoverController = ShadPopoverController();

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: popoverController,
      popover:
          (context) => ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: Text('Logout'),
                  ),
                  onTap: () {
                    showShadDialog(
                      context: context,
                      builder:
                          (context) => ShadDialog.alert(
                            title: const Text('Are you absolutely sure?'),
                            description: const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                              ),
                            ),
                            actions: [
                              ShadButton.outline(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              ShadButton(
                                child: const Text('Continue'),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LandingPage(),
                                    ),
                                    (Route<dynamic> route) =>
                                        false, // This predicate always returns false, removing all routes
                                  );
                                },
                              ),
                            ],
                          ),
                    );
                  },
                ),
              ],
            ),
          ),
      child: ShadButton.ghost(
        onPressed: popoverController.toggle,
        child: const Icon(LucideIcons.ellipsisVertical, size: 25),
      ),
    );
  }
}
