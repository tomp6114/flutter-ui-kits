import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A custom painter providing structural mapping of regular n-sided polygons natively.
class PolygonPainter extends CustomPainter {
  final int sides;
  final Color color;
  final PaintingStyle style;
  final double strokeWidth;
  final double cornerRadius;

  PolygonPainter({
    required this.sides,
    required this.color,
    this.style = PaintingStyle.fill,
    this.strokeWidth = 1.0,
    this.cornerRadius = 0.0,
  }) : assert(sides > 2, 'A polygon must have at least 3 sides.');

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = style
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = math.min(centerX, centerY);

    final path = Path();
    final angle = (2 * math.pi) / sides;

    for (int i = 0; i < sides; i++) {
        final x = centerX + radius * math.cos(i * angle - math.pi / 2);
        final y = centerY + radius * math.sin(i * angle - math.pi / 2);
        if (i == 0) {
            path.moveTo(x, y);
        } else {
            path.lineTo(x, y);
        }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant PolygonPainter oldDelegate) {
    return oldDelegate.sides != sides ||
        oldDelegate.color != color ||
        oldDelegate.style != style ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.cornerRadius != cornerRadius;
  }
}
