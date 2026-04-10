import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A set of noise providing grainy film texture background mappings natively.
class NoisePainter extends CustomPainter {
  final Color color;
  final double density;

  NoisePainter({
    required this.color,
    this.density = 0.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random();

    for (int i = 0; i < (size.width * size.height * density / 10).toInt(); i++) {
        final x = random.nextDouble() * size.width;
        final y = random.nextDouble() * size.height;
        canvas.drawRect(
          Rect.fromLTWH(x, y, 1, 1),
          Paint()..color = color.withValues(alpha: random.nextDouble() * 0.1),
        );
    }
  }

  @override
  bool shouldRepaint(covariant NoisePainter oldDelegate) => false;
}
