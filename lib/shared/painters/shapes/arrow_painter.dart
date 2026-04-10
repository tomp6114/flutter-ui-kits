import 'package:flutter/material.dart';

/// A set of arrow providing directional arrow, curved/straight mappings natively.
class ArrowPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double headSize;

  ArrowPainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.headSize = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    // Body
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width - headSize, size.height / 2);
    
    // Head
    path.moveTo(size.width - headSize, size.height / 2 - headSize / 2);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - headSize, size.height / 2 + headSize / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ArrowPainter oldDelegate) => true;
}
