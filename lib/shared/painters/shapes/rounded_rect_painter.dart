import 'package:flutter/material.dart';

/// A set of rounded rect providing individual corner radius control mappings natively.
class RoundedRectPainter extends CustomPainter {
  final Color color;
  final Radius topLeft;
  final Radius topRight;
  final Radius bottomLeft;
  final Radius bottomRight;
  final PaintingStyle style;
  final double strokeWidth;

  RoundedRectPainter({
    required this.color,
    this.topLeft = Radius.zero,
    this.topRight = Radius.zero,
    this.bottomLeft = Radius.zero,
    this.bottomRight = Radius.zero,
    this.style = PaintingStyle.fill,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = style
      ..strokeWidth = strokeWidth;

    final rrect = RRect.fromLTRBAndCorners(
      0, 0, size.width, size.height,
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
    );

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant RoundedRectPainter oldDelegate) => true;
}
