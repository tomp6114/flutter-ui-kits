import 'package:flutter/material.dart';

/// A set of triangle providing pointing up down left right mappings natively.
class TrianglePainter extends CustomPainter {
  final Color color;
  final NavigationDirection direction;
  final PaintingStyle style;

  TrianglePainter({
    required this.color,
    this.direction = NavigationDirection.up,
    this.style = PaintingStyle.fill,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = style;
    
    final path = Path();
    switch (direction) {
      case NavigationDirection.up:
        path.moveTo(size.width / 2, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height);
        break;
      case NavigationDirection.down:
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width / 2, size.height);
        break;
      case NavigationDirection.left:
        path.moveTo(size.width, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height / 2);
        break;
      case NavigationDirection.right:
        path.moveTo(0, 0);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(0, size.height);
        break;
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant TrianglePainter oldDelegate) => true;
}

enum NavigationDirection { up, down, left, right }
