import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A set of segment providing segments, gap, explode on tap, and center label mappings natively.
class PieChartPainter extends CustomPainter {
  final List<PieSegment> segments;
  final double gap;

  PieChartPainter({
    required this.segments,
    this.gap = 0.02,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double total = segments.fold(0, (sum, item) => sum + item.value);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    
    double startAngle = -math.pi / 2;
    
    for (final segment in segments) {
        final sweepAngle = (segment.value / total) * 2 * math.pi;
        final paint = Paint()..color = segment.color;
        
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle + gap,
          sweepAngle - (gap * 2),
          true,
          paint,
        );
        
        startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant PieChartPainter oldDelegate) => true;
}

class PieSegment {
  final double value;
  final Color color;
  final String label;

  PieSegment({required this.value, required this.color, required this.label});
}
