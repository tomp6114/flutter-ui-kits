import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/shared/widgets/layout/inner_shadow_container.dart';

/// A premium neumorphic toggle switch providing animated inset/raised states natively.
class NeumorphicToggle extends StatelessWidget {
  /// Whether the toggle is on or off.
  final bool value;
  /// Callback executed when the value changes.
  final ValueChanged<bool> onChanged;
  /// The color of the active state.
  final Color? activeColor;
  /// The width of the toggle.
  final double width;
  /// The height of the toggle.
  final double height;

  const NeumorphicToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.width = 60.0,
    this.height = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).cardColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final lightShadow = isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white;
    final darkShadow = isDark ? Colors.black.withValues(alpha: 0.5) : Colors.black.withValues(alpha: 0.2);

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: InnerShadowContainer(
        width: width,
        height: height,
        color: bgColor,
        borderRadius: BorderRadius.circular(height / 2),
        shadowColor: darkShadow,
        blurRadius: 4,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: value ? width - height + 2 : 2,
              top: 2,
              bottom: 2,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: height - 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: value ? (activeColor ?? Theme.of(context).primaryColor) : bgColor,
                  boxShadow: [
                    BoxShadow(
                      color: darkShadow.withValues(alpha: 0.5),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                    BoxShadow(
                      color: lightShadow.withValues(alpha: 0.8),
                      offset: const Offset(-1, -1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: value 
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
