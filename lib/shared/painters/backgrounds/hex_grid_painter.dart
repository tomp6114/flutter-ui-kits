import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A set of hex providing honeycomb grid pattern mappings natively.
class HexGridPainter extends CustomPainter {
  final Color color;
  final double radius;

  HexGridPainter({
    required this.color,
    this.radius = 20.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final double width = radius * math.sqrt(3);
    final double height = radius * 2;
    
    for (double y = 0; y < size.height + height; y += height * 0.75) {
      final double xOffset = ((y / (height * 0.75)).round() % 2 == 0) ? 0 : width / 2;
      for (double x = -width; x < size.width + width; x += width) {
        _drawHex(canvas, Offset(x + xOffset, y), radius, paint);
      }
    }
  }

  void _drawHex(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i - (math.pi / 2);
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
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
  bool shouldRepaint(covariant HexGridPainter oldDelegate) => false;
}
