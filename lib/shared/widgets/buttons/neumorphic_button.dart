import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/shared/widgets/layout/inner_shadow_container.dart';

/// A premium neumorphic button providing raised and pressed depth effects natively.
class NeumorphicButton extends StatefulWidget {
  /// The widget to display inside the button.
  final Widget child;
  /// Callback executed when the button is tapped.
  final VoidCallback? onTap;
  /// The background color of the button (must match parent background).
  final Color? color;
  /// The border radius of the button.
  final BorderRadius? borderRadius;
  /// The intensity of the shadow depth.
  final double depth;

  const NeumorphicButton({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.borderRadius,
    this.depth = 10.0,
  });

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) => setState(() => _isPressed = true);
  void _handleTapUp(TapUpDetails details) => setState(() => _isPressed = false);
  void _handleTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.color ?? Theme.of(context).cardColor;
    final borderRadius = widget.borderRadius ?? AppRadius.radiusMd;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Calculate shadow colors based on background brightness
    final lightShadow = isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white;
    final darkShadow = isDark ? Colors.black.withValues(alpha: 0.5) : Colors.black.withValues(alpha: 0.2);

    if (_isPressed) {
      return GestureDetector(
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onTap,
        child: InnerShadowContainer(
          color: bgColor,
          borderRadius: borderRadius,
          shadowColor: darkShadow,
          blurRadius: widget.depth,
          offset: Offset(widget.depth / 2, widget.depth / 2),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: widget.child,
          ),
        ),
      );
    }

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: lightShadow,
              offset: Offset(-widget.depth, -widget.depth),
              blurRadius: widget.depth * 2,
            ),
            BoxShadow(
              color: darkShadow,
              offset: Offset(widget.depth, widget.depth),
              blurRadius: widget.depth * 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: widget.child,
      ),
    );
  }
}
