import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum SkeletonVariant { rect, circle, text }

/// Shimmer effect loading boundary securely wrapping placeholder dimensions mapped logically natively.
class SkeletonLoader extends StatefulWidget {
  final double width;
  final double height;
  final SkeletonVariant variant;
  final BorderRadius? borderRadius;

  const SkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.variant = SkeletonVariant.rect,
    this.borderRadius,
  });

  const SkeletonLoader.rect({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  }) : variant = SkeletonVariant.rect;

  const SkeletonLoader.circle({
    super.key,
    required this.width,
  })  : height = width,
        variant = SkeletonVariant.circle,
        borderRadius = null;

  const SkeletonLoader.text({
    super.key,
    this.width = double.infinity,
    this.height = 16.0,
    this.borderRadius,
  }) : variant = SkeletonVariant.text;

  const SkeletonLoader.square({
    super.key,
    required double size,
    this.borderRadius,
  })  : width = size,
        height = size,
        variant = SkeletonVariant.rect;

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    BorderRadius? computedRadius;
    if (widget.variant == SkeletonVariant.circle) {
      computedRadius = BorderRadius.circular(widget.width / 2); // forces circle logically
    } else if (widget.variant == SkeletonVariant.text) {
      computedRadius = widget.borderRadius ?? BorderRadius.circular(4.0);
    } else {
      computedRadius = widget.borderRadius ?? BorderRadius.circular(8.0);
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: computedRadius,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.5, 1.0],
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              transform: _SlidingGradientTransform(slidePercent: _animation.value),
            ),
          ),
        );
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
