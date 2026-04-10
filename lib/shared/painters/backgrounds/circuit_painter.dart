import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A set of circuits providing PCB-style line network background mappings natively.
class CircuitPainter extends CustomPainter {
  final Color color;
  final int complexity;

  CircuitPainter({
    required this.color,
    this.complexity = 30,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final random = math.Random(42);

    for (int i = 0; i < complexity; i++) {
        double x = random.nextDouble() * size.width;
        double y = random.nextDouble() * size.height;
        
        final path = Path();
        path.moveTo(x, y);
        
        for (int j = 0; j < 3; j++) {
            final isHorizontal = random.nextBool();
            if (isHorizontal) {
                x += (random.nextBool() ? 40.0 : -40.0);
            } else {
                y += (random.nextBool() ? 40.0 : -40.0);
            }
            path.lineTo(x, y);
            
            if (random.nextBool()) {
                canvas.drawCircle(Offset(x, y), 2.5, Paint()..color = color);
            }
        }
        canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CircuitPainter oldDelegate) => false;
}
