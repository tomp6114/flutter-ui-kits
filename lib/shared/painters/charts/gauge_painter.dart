import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A set of gauge providing semi-circle progress gauge with needle mappings natively.
class GaugePainter extends CustomPainter {
  final double value; // 0.0 to 1.0
  final Color color;

  GaugePainter({
    required this.value,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;
    
    final paint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0
      ..strokeCap = StrokeCap.round;

    // Track
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 10),
      math.pi,
      math.pi,
      false,
      paint,
    );

    // Progress
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 10),
      math.pi,
      math.pi * value,
      false,
      progressPaint,
    );

    // Needle
    final needlePaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;
    
    final angle = math.pi + (math.pi * value);
    canvas.drawLine(center, Offset(center.dx + (radius - 20) * math.cos(angle), center.dy + (radius - 20) * math.sin(angle)), needlePaint);
  }

  @override
  bool shouldRepaint(covariant GaugePainter oldDelegate) => true;
}
