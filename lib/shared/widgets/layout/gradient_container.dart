import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';

/// A utility container providing complex linear or radial gradient backgrounds natively.
class GradientContainer extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;

  const GradientContainer({
    super.key,
    required this.child,
    required this.colors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.borderRadius,
    this.padding,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? AppRadius.radiusMd,
        gradient: LinearGradient(
          colors: colors,
          begin: begin,
          end: end,
        ),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
