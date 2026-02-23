import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portal/ui/core/ui/loading_overlay.dart';
import 'package:portal/ui/core/ui/portal_animated_logo.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Auth layout matching the wireframe:
/// - Desktop/Tablet: Logo on left, form on right (split view)
/// - Mobile: Logo on top (smaller), form below
class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    this.formKey,
    this.title,
    this.centerTitle = false,
    this.isLoading = false,
    this.showBackButton = false,
    this.onBack,
    required this.children,
  });

  final String? title;
  final bool centerTitle;
  final List<Widget> children;
  final GlobalKey<ShadFormState>? formKey;
  final bool isLoading;
  final bool showBackButton;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final size = MediaQuery.of(context).size;
    final isMobile =
        defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS ||
        size.width < 700;

    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: showBackButton ? AppBar() : null,
        body: SafeArea(
          child: isMobile ? _buildMobile(theme) : _buildDesktop(context, theme),
        ),
      ),
    );
  }

  Widget _buildMobile(ShadThemeData theme) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Logo area
                const PortalAnimatedLogo(dimension: 300, bounceHeight: 15),
                // Title
                if (title != null)
                  Text(
                    title!,
                    style: theme.textTheme.h2.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                    textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                  ),
                const SizedBox(height: 30),
                // Form
                _buildForm(theme),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context, ShadThemeData theme) {
    return Row(
      children: [
        // Left: Logo
        Expanded(
          flex: 5,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const PortalAnimatedLogo(dimension: 400, bounceHeight: 20),
                const SizedBox(height: 24),
                Text(
                  'Portal',
                  style: theme.textTheme.h1Large.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        // Right: Form
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (title != null) ...[
                        Text(
                          title!,
                          style: theme.textTheme.h2.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1,
                          ),
                          textAlign: centerTitle
                              ? TextAlign.center
                              : TextAlign.start,
                        ),
                        const SizedBox(height: 32),
                      ],
                      _buildForm(theme),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(ShadThemeData theme) {
    return ShadForm(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: centerTitle
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
