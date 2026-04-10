import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A set of particles providing animated floating dots background mappings natively.
class ParticlePainter extends CustomPainter {
  final Color color;
  final int count;
  final double animationValue;

  ParticlePainter({
    required this.color,
    this.count = 20,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(12345);

    for (int i = 0; i < count; i++) {
        final double xSeed = random.nextDouble();
        final double ySeed = random.nextDouble();
        final double radius = random.nextDouble() * 3 + 1;
        
        final double x = (xSeed * size.width + (math.sin(animationValue * 2 * math.pi + i) * 20)) % size.width;
        final double y = (ySeed * size.height + (math.cos(animationValue * 2 * math.pi + i) * 20)) % size.height;
        
        canvas.drawCircle(
          Offset(x, y),
          radius,
          Paint()..color = color.withValues(alpha: 0.3),
        );
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}
