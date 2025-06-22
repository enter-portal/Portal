import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AuthPageLayout extends StatelessWidget {
  const AuthPageLayout({
    super.key,
    this.formKey,
    this.title,
    this.leading,
    required this.children,
  });

  final String? title;
  final List<Widget> children;
  final GlobalKey<ShadFormState>? formKey;
  final IconButton? leading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          title != null ? AppBar(title: Text(title!), leading: leading) : null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraint.maxHeight,
                  minWidth: constraint.maxWidth,
                ),
                child: IntrinsicHeight(
                  child: Center(
                    child: ShadForm(
                      key: formKey ?? formKey,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth:
                              Platform.isAndroid || Platform.isIOS ? 350 : 400,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children:
                              Platform.isAndroid || Platform.isIOS
                                  ? children
                                  : [Spacer(), ...children, Spacer()],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
