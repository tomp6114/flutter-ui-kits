import 'package:flutter/material.dart';

/// A custom painter providing organic Bezier squiggle decoration mappings natively.
class SquigglePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double frequency;
  final double amplitude;

  SquigglePainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.frequency = 4.0,
    this.amplitude = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height / 2);

    final step = size.width / (frequency * 2);
    for (int i = 0; i < frequency * 2; i++) {
        final x1 = (i * step) + (step / 2);
        final y1 = (i % 2 == 0) ? (size.height / 2 - amplitude) : (size.height / 2 + amplitude);
        final x2 = (i + 1) * step;
        final y2 = size.height / 2;
        path.quadraticBezierTo(x1, y1, x2, y2);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SquigglePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.frequency != frequency ||
        oldDelegate.amplitude != amplitude;
  }
}
