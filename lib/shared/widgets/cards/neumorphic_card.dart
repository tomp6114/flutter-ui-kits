import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/shared/widgets/layout/inner_shadow_container.dart';

enum NeumorphicVariant { flat, concave, convex, inset }

/// A premium neumorphic card providing depth variants (raised, concave, convex, inset) natively.
class NeumorphicCard extends StatelessWidget {
  /// The widget to display inside the card.
  final Widget child;
  /// The background color (must match parent).
  final Color? color;
  /// The border radius of the card.
  final BorderRadius? borderRadius;
  /// The shadow depth.
  final double depth;
  /// The visual style variant.
  final NeumorphicVariant variant;
  /// Optional padding for the content.
  final EdgeInsetsGeometry? padding;

  const NeumorphicCard({
    super.key,
    required this.child,
    this.color,
    this.borderRadius,
    this.depth = 10.0,
    this.variant = NeumorphicVariant.flat,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = color ?? Theme.of(context).cardColor;
    final radius = borderRadius ?? AppRadius.radiusLg;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final lightShadow = isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white;
    final darkShadow = isDark ? Colors.black.withValues(alpha: 0.5) : Colors.black.withValues(alpha: 0.2);

    if (variant == NeumorphicVariant.inset) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: InnerShadowContainer(
          color: bgColor,
          borderRadius: radius,
          shadowColor: darkShadow,
          blurRadius: depth,
          offset: Offset(depth / 2, depth / 2),
          child: Padding(
            padding: padding!,
            child: child,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: radius,
        gradient: _getGradient(bgColor),
        boxShadow: [
          BoxShadow(
            color: lightShadow,
            offset: Offset(-depth, -depth),
            blurRadius: depth * 2,
          ),
          BoxShadow(
            color: darkShadow,
            offset: Offset(depth, depth),
            blurRadius: depth * 2,
          ),
        ],
      ),
      child: Padding(
        padding: padding!,
        child: child,
      ),
    );
  }

  LinearGradient? _getGradient(Color baseColor) {
    if (variant == NeumorphicVariant.flat || variant == NeumorphicVariant.inset) return null;
    
    final lightColor = Color.lerp(baseColor, Colors.white, 0.05)!;
    final darkColor = Color.lerp(baseColor, Colors.black, 0.05)!;

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: variant == NeumorphicVariant.concave 
          ? [darkColor, lightColor] 
          : [lightColor, darkColor],
    );
  }
}
