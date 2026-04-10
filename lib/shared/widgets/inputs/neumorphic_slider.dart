import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/shared/widgets/layout/inner_shadow_container.dart';

/// A premium neumorphic slider providing depth-based track and thumb effects natively.
class NeumorphicSlider extends StatelessWidget {
  /// The current value of the slider.
  final double value;
  /// Callback executed when the value changes.
  final ValueChanged<double> onChanged;
  /// The minimum value.
  final double min;
  /// The maximum value.
  final double max;
  /// The color of the active track.
  final Color? activeColor;

  const NeumorphicSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).cardColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final darkShadow = isDark ? Colors.black.withValues(alpha: 0.5) : Colors.black.withValues(alpha: 0.2);
    final lightShadow = isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double progress = (value - min) / (max - min);
        final double thumbPos = progress * width;

        return GestureDetector(
          onPanUpdate: (details) {
            final double newValue = (details.localPosition.dx / width).clamp(0.0, 1.0);
            onChanged(min + (newValue * (max - min)));
          },
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Inset Track
                InnerShadowContainer(
                  height: 12,
                  width: double.infinity,
                  color: bgColor,
                  borderRadius: BorderRadius.circular(6),
                  shadowColor: darkShadow,
                  blurRadius: 4,
                  child: const SizedBox.shrink(),
                ),
                // Active Fill
                Positioned(
                  left: 0,
                  child: Container(
                    height: 12,
                    width: thumbPos,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(
                        colors: [
                          (activeColor ?? Theme.of(context).primaryColor).withValues(alpha: 0.7),
                          (activeColor ?? Theme.of(context).primaryColor),
                        ],
                      ),
                    ),
                  ),
                ),
                // Raised Thumb
                Positioned(
                  left: (thumbPos - 14).clamp(0.0, width - 28),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: bgColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: darkShadow.withValues(alpha: 0.5),
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                        ),
                        BoxShadow(
                          color: lightShadow.withValues(alpha: 0.8),
                          offset: const Offset(-2, -2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeColor ?? Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
