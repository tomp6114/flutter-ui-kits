import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A set of loading Providing rotating split ring with trailing fade mappings natively.
class LoadingRingPainter extends CustomPainter {
  final double animationValue;
  final Color color;

  LoadingRingPainter({
    required this.animationValue,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 2.0;
    
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, animationValue * 2 * math.pi, math.pi * 1.5, false, paint);
  }

  @override
  bool shouldRepaint(covariant LoadingRingPainter oldDelegate) => true;
}
