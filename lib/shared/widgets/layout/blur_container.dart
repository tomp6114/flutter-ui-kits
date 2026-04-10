import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';

/// A structural container providing glassmorphism mappings natively.
class BlurContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final Color? color;
  final BorderRadius? borderRadius;
  final double opacity;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;

  const BlurContainer({
    super.key,
    required this.child,
    this.blur = 10.0,
    this.color = Colors.white,
    this.borderRadius,
    this.opacity = 0.1,
    this.padding,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? AppRadius.radiusMd,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: (color ?? Colors.white).withValues(alpha: opacity),
            borderRadius: borderRadius ?? AppRadius.radiusMd,
            border: border ?? Border.all(
              color: (color ?? Colors.white).withValues(alpha: opacity + 0.1),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
