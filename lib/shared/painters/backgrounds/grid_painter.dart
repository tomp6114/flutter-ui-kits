import 'package:flutter/material.dart';

/// A set of grid providing dot grid / line grid / cross grid mappings natively.
class GridPainter extends CustomPainter {
  final Color color;
  final double spacing;
  final bool isLines;

  GridPainter({
    required this.color,
    this.spacing = 20.0,
    this.isLines = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = 0.5;

    for (double x = 0; x <= size.width; x += spacing) {
        if (isLines) {
            canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
        } else {
            for (double y = 0; y <= size.height; y += spacing) {
                canvas.drawCircle(Offset(x, y), 1, paint);
            }
        }
    }
    
    if (isLines) {
        for (double y = 0; y <= size.height; y += spacing) {
            canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
        }
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) => false;
}
