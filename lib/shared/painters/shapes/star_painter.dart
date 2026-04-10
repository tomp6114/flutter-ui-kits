import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A set of star providing N-point star and inner radius ratio mappings natively.
class StarPainter extends CustomPainter {
  final int points;
  final Color color;
  final double innerRadiusRatio;

  StarPainter({
    this.points = 5,
    required this.color,
    this.innerRadiusRatio = 0.4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final outerRadius = math.min(centerX, centerY);
    final innerRadius = outerRadius * innerRadiusRatio;

    final double step = math.pi / points;

    for (int i = 0; i < 2 * points; i++) {
        final radius = (i % 2 == 0) ? outerRadius : innerRadius;
        final angle = i * step - math.pi / 2;
        final x = centerX + radius * math.cos(angle);
        final y = centerY + radius * math.sin(angle);
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
  bool shouldRepaint(covariant StarPainter oldDelegate) => true;
}
