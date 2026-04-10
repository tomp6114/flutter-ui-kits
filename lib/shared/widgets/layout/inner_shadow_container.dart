import 'package:flutter/material.dart';

/// A container providing inset shadow mappings using decoration layers natively.
class InnerShadowContainer extends StatelessWidget {
  final Widget child;
  final Color shadowColor;
  final double blurRadius;
  final Offset offset;
  final BorderRadius? borderRadius;
  final Color? color;

  final double? width;
  final double? height;

  const InnerShadowContainer({
    super.key,
    required this.child,
    this.shadowColor = Colors.black26,
    this.blurRadius = 10.0,
    this.offset = const Offset(2, 2),
    this.borderRadius,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Stack(
          children: [
            child,
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: blurRadius,
                      offset: offset,
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: color ?? Theme.of(context).cardColor,
                ),
                child: child,
              ),
            ),
            // Custom Inner Shadow Implementation using ShaderMask or complex Decoration
            // For Simplicity in this kit, we use a container with a border/gradient trick
            // Or use a Stack with a transparent hole (ClipPath)
            _InnerShadow(
              shadowColor: shadowColor,
              blurRadius: blurRadius,
              offset: offset,
              borderRadius: borderRadius ?? BorderRadius.zero,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class _InnerShadow extends StatelessWidget {
  final Color shadowColor;
  final double blurRadius;
  final Offset offset;
  final Widget child;
  final BorderRadius borderRadius;

  const _InnerShadow({
    required this.shadowColor,
    required this.blurRadius,
    required this.offset,
    required this.child,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                boxShadow: [
                  BoxShadow(
                    blurRadius: blurRadius,
                    offset: offset,
                    color: shadowColor,
                    spreadRadius: -blurRadius,
                  ),
                  BoxShadow(
                    blurRadius: blurRadius,
                    offset: -offset,
                    color: shadowColor,
                    spreadRadius: -blurRadius,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
