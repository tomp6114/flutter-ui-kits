import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/shared/widgets/layout/blur_container.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';

/// A premium glassmorphism card providing frosted glass effects and inner glow mappings natively.
class GlassmorphismCard extends StatelessWidget {
  /// The widget to display inside the card.
  final Widget child;
  /// The intensity of the background blur.
  final double blur;
  /// The base color of the glass panel.
  final Color? color;
  /// The opacity of the glass panel.
  final double opacity;
  /// The border radius of the card.
  final BorderRadius? borderRadius;
  /// Optional padding for the content.
  final EdgeInsetsGeometry? padding;

  const GlassmorphismCard({
    super.key,
    required this.child,
    this.blur = 15.0,
    this.color,
    this.opacity = 0.15,
    this.borderRadius,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
  });

  @override
  Widget build(BuildContext context) {
    final panelColor = color ?? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white);
    
    return BlurContainer(
      blur: blur,
      opacity: opacity,
      color: panelColor,
      borderRadius: borderRadius ?? AppRadius.radiusLg,
      padding: padding,
      border: Border.all(
        color: panelColor.withValues(alpha: opacity + 0.1),
        width: 1.5,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? AppRadius.radiusLg,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              panelColor.withValues(alpha: 0.1),
              panelColor.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
