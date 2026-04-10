import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A set of confetti providing falling multi-colored shape background mappings natively.
class ConfettiPainter extends CustomPainter {
  final double animationValue;
  final List<Color> colors;

  ConfettiPainter({
    required this.animationValue,
    this.colors = const [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.orange, Colors.purple],
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(1337);
    for (int i = 0; i < 50; i++) {
        final double xSeed = random.nextDouble();
        final double ySeed = random.nextDouble();
        final Color color = colors[random.nextInt(colors.length)];
        
        final double x = xSeed * size.width;
        final double y = (ySeed * size.height + animationValue * size.height) % size.height;
        
        final double rotation = animationValue * 2 * math.pi * (random.nextBool() ? 1 : -1);
        
        canvas.save();
        canvas.translate(x, y);
        canvas.rotate(rotation);
        
        final paint = Paint()..color = color.withValues(alpha: 0.8);
        if (i % 3 == 0) {
            canvas.drawRect(const Rect.fromLTWH(-4, -4, 8, 8), paint);
        } else if (i % 3 == 1) {
            canvas.drawCircle(Offset.zero, 4, paint);
        } else {
            final path = Path();
            path.moveTo(0, -5);
            path.lineTo(5, 5);
            path.lineTo(-5, 5);
            path.close();
            canvas.drawPath(path, paint);
        }
        
        canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) => true;
}
