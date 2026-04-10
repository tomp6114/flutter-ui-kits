import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A set of spider providing spider/radar polygon with filled area mappings natively.
class RadarChartPainter extends CustomPainter {
  final List<double> values; // 0.0 to 1.0
  final List<String> labels;
  final Color color;

  RadarChartPainter({
    required this.values,
    required this.labels,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = math.min(centerX, centerY);
    final count = values.length;

    final paint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    
    final outlinePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();
    for (int i = 0; i < count; i++) {
        final angle = (2 * math.pi / count) * i - math.pi / 2;
        final r = radius * values[i];
        final x = centerX + r * math.cos(angle);
        final y = centerY + r * math.sin(angle);
        if (i == 0) {
            path.moveTo(x, y);
        } else {
            path.lineTo(x, y);
        }
    }
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, outlinePaint);

    // Draw axes
    final axisPaint = Paint()..color = Colors.grey.withValues(alpha: 0.2);
    for (int i = 0; i < count; i++) {
        final angle = (2 * math.pi / count) * i - math.pi / 2;
        canvas.drawLine(Offset(centerX, centerY), Offset(centerX + radius * math.cos(angle), centerY + radius * math.sin(angle)), axisPaint);
    }
  }

  @override
  bool shouldRepaint(covariant RadarChartPainter oldDelegate) => true;
}
