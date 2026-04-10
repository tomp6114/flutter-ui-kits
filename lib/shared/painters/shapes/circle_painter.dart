import 'package:flutter/material.dart';

/// A set of circle providing gradient circle, dashed stroke, and arc fill mappings natively.
class CirclePainter extends CustomPainter {
  final Color color;
  final PaintingStyle style;
  final double strokeWidth;
  final bool isDashed;
  final double? sweepAngle;

  CirclePainter({
    required this.color,
    this.style = PaintingStyle.fill,
    this.strokeWidth = 2.0,
    this.isDashed = false,
    this.sweepAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = style
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    if (sweepAngle != null) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -1.5708, // -90 degrees
        sweepAngle!,
        style == PaintingStyle.fill,
        paint,
      );
    } else {
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) => true;
}
