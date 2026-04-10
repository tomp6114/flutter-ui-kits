import 'package:flutter/material.dart';

/// A set of blob providing organic blob using cubic bezier curves mappings natively.
class BlobPainter extends CustomPainter {
  final Color color;
  final List<double> seed; // Random-ish offsets for the points

  BlobPainter({
    required this.color,
    this.seed = const [0.8, 1.2, 0.9, 1.1, 0.7, 1.3],
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 3;

    final List<Offset> points = [];
    final int count = seed.length;
    for (int i = 0; i < count; i++) {
        final r = radius * seed[i];
        points.add(Offset(centerX + r * 1.5 * (i % 2 == 0 ? 1 : 0.8), centerY + r * 1.5 * (i % 2 == 0 ? 0.8 : 1)));
    }

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 0; i < points.length; i++) {
        final p1 = points[i];
        final p2 = points[(i + 1) % points.length];
        
        final controlPoint1 = Offset(
          p1.dx + (p2.dx - p1.dx) / 2,
          p1.dy,
        );
        final controlPoint2 = Offset(
          p1.dx + (p2.dx - p1.dx) / 2,
          p2.dy,
        );
        
        path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, p2.dx, p2.dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant BlobPainter oldDelegate) => true;
}
