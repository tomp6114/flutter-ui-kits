import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'dart:ui';

/// A full-screen glassmorphism overlay providing frosted background focus.
class BlurOverlay extends StatelessWidget {
  final Widget child;
  final double blur;
  final Color? color;
  final VoidCallback? onDismiss;
  final bool isVisible;

  const BlurOverlay({
    super.key,
    required this.child,
    this.blur = 10.0,
    this.color,
    this.onDismiss,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Positioned.fill(
      child: GestureDetector(
        onTap: onDismiss,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            color: color ?? context.colorScheme.shadow.withValues(alpha: 0.1),
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
