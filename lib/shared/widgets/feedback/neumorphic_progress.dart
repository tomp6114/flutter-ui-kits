import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/shared/widgets/layout/inner_shadow_container.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';

/// A premium neumorphic progress bar providing depth-based tracking effects natively.
class NeumorphicProgress extends StatelessWidget {
  /// The current progress value (0 to 1).
  final double value;
  /// The height of the progress bar.
  final double height;
  /// The base color of the progress bar.
  final Color? color;
  /// The color of the active progress fill.
  final Color? activeColor;
  /// Optional label to display above the bar.
  final String? label;

  const NeumorphicProgress({
    super.key,
    required this.value,
    this.height = 16.0,
    this.color,
    this.activeColor,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = color ?? Theme.of(context).cardColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final darkShadow = isDark ? Colors.black.withValues(alpha: 0.5) : Colors.black.withValues(alpha: 0.2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Text(
              label!,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
        ],
        InnerShadowContainer(
          height: height,
          width: double.infinity,
          color: bgColor,
          borderRadius: BorderRadius.circular(height / 2),
          shadowColor: darkShadow,
          blurRadius: 4,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: constraints.maxWidth * value,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height / 2),
                      gradient: LinearGradient(
                        colors: [
                          (activeColor ?? Theme.of(context).primaryColor).withValues(alpha: 0.8),
                          (activeColor ?? Theme.of(context).primaryColor),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (activeColor ?? Theme.of(context).primaryColor).withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
