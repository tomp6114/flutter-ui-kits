import 'package:flutter/material.dart';

enum PatternType { dots, grid, stripes }

/// A custom painter providing geometric background pattern mappings natively.
class PatternPainter extends CustomPainter {
  final PatternType type;
  final Color color;
  final double spacing;
  final double strokeWidth;

  PatternPainter({
    this.type = PatternType.dots,
    required this.color,
    this.spacing = 20.0,
    this.strokeWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    switch (type) {
      case PatternType.dots:
        _drawDots(canvas, size, paint);
        break;
      case PatternType.grid:
        _drawGrid(canvas, size, paint);
        break;
      case PatternType.stripes:
        _drawStripes(canvas, size, paint);
        break;
    }
  }

  void _drawDots(Canvas canvas, Size size, Paint paint) {
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), strokeWidth, paint);
      }
    }
  }

  void _drawGrid(Canvas canvas, Size size, Paint paint) {
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  void _drawStripes(Canvas canvas, Size size, Paint paint) {
    for (double x = -size.height; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant PatternPainter oldDelegate) {
    return oldDelegate.type != type ||
        oldDelegate.color != color ||
        oldDelegate.spacing != spacing ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
