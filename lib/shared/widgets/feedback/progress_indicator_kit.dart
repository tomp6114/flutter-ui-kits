import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'dart:math';

enum ProgressVariant { linear, circular, dots }

/// Multi-variant loading boundary securely handling linear, circular, and animated dots variants securely natively.
class ProgressIndicatorKit extends StatefulWidget {
  final ProgressVariant variant;
  final double? value; // null implies indeterminate
  final Color? color;
  final double size; // applies to circular/dots

  const ProgressIndicatorKit({
    super.key,
    this.variant = ProgressVariant.circular,
    this.value,
    this.color,
    this.size = 36.0,
  });

  @override
  State<ProgressIndicatorKit> createState() => _ProgressIndicatorKitState();
}

class _ProgressIndicatorKitState extends State<ProgressIndicatorKit> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.variant == ProgressVariant.dots) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1200),
      )..repeat();
    }
  }

  @override
  void dispose() {
    if (widget.variant == ProgressVariant.dots) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = widget.color ?? context.colorScheme.primary;

    if (widget.variant == ProgressVariant.linear) {
      return LinearProgressIndicator(
        value: widget.value,
        backgroundColor: activeColor.withValues(alpha: 0.2),
        valueColor: AlwaysStoppedAnimation<Color>(activeColor),
      );
    }

    if (widget.variant == ProgressVariant.dots) {
      return SizedBox(
        width: widget.size * 2,
        height: widget.size / 2,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                // Calculate scale based on sine wave offset by index
                final double delay = index * 0.2;
                final double value = sin((_controller.value - delay) * 2 * pi);
                // Map from [-1, 1] to [0.5, 1.0] visually
                final double scale = 0.75 + (value * 0.25);

                return Transform.scale(
                  scale: scale.clamp(0.5, 1.0),
                  child: Container(
                    width: widget.size / 3,
                    height: widget.size / 3,
                    decoration: BoxDecoration(
                      color: activeColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            );
          },
        ),
      );
    }

    // Circular
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CircularProgressIndicator(
        value: widget.value,
        strokeWidth: 3.0,
        backgroundColor: activeColor.withValues(alpha: 0.2),
        valueColor: AlwaysStoppedAnimation<Color>(activeColor),
      ),
    );
  }
}
