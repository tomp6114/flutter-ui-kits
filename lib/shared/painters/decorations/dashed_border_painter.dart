import 'package:flutter/material.dart';

/// A set of dashed providing dashed border for any container mappings natively.
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double gapWidth;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.gapWidth = 3.0,
    this.borderRadius = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    if (borderRadius > 0) {
        path.addRRect(RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(borderRadius)));
    } else {
        path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    final dashPath = Path();
    double distance = 0.0;
    for (final pathMetric in path.computeMetrics()) {
        while (distance < pathMetric.length) {
            dashPath.addPath(
              pathMetric.extractPath(distance, distance + dashWidth),
              Offset.zero,
            );
            distance += dashWidth + gapWidth;
        }
        distance = 0.0;
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) => true;
}
