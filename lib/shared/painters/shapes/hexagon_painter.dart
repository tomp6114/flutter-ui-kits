import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A set of hexagon providing honeycomb hexagon shape mappings natively.
class HexagonPainter extends CustomPainter {
  final Color color;
  final PaintingStyle style;
  final double strokeWidth;

  HexagonPainter({
    required this.color,
    this.style = PaintingStyle.fill,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = style
      ..strokeWidth = strokeWidth;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = math.min(centerX, centerY);

    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i;
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
  bool shouldRepaint(covariant HexagonPainter oldDelegate) => true;
}
