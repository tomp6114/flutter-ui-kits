import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';

/// Frosted glass overlay relying on ImageFilter blur processing securely mapped bounding visually.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final double blurAmount;
  final Color? colorTint;
  final double opacity;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = AppRadius.radiusMd,
    this.blurAmount = 10.0,
    this.colorTint,
    this.opacity = 0.2, // standard light frost
  });

  @override
  Widget build(BuildContext context) {
    final tint = colorTint ?? Colors.white;

    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: tint.withValues(alpha: opacity),
            borderRadius: borderRadius,
            border: Border.all(
              color: tint.withValues(alpha: opacity + 0.1), // slightly stronger border to catch edge
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
