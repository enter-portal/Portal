import 'package:flutter/material.dart';

/// A modern full-screen loading overlay.
///
/// Wraps [child] in a [Stack]. When [isLoading] is true, renders a blurred,
/// semi-transparent barrier on top with an animated spinner so the user
/// cannot interact with the underlying UI.
///
/// Usage:
/// ```dart
/// LoadingOverlay(
///   isLoading: isLoading,
///   child: MyScreen(),
/// )
/// ```
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        child,
        if (isLoading) ...[
          /// Block all touch events
          const ModalBarrier(dismissible: false, color: Colors.transparent),

          /// Overlay background
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.surface.withValues(alpha: 0.7),
              ),
            ),
          ),

          /// Spinner
          Center(
            child: Material(
              type: MaterialType.transparency,
              child: _SpinnerCard(colorScheme: colorScheme),
            ),
          ),
        ],
      ],
    );
  }
}

class _SpinnerCard extends StatelessWidget {
  const _SpinnerCard({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 28),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 32,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              strokeCap: StrokeCap.round,
              color: colorScheme.primary,
            ),
          ),
          Text(
            'Please wait…',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
