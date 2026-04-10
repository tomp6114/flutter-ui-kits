import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A data model for a single ring in the [DonutChartPainter].
class RingData {
  final double value; // 0.0 to 1.0
  final Color color;
  final String? label;

  const RingData({required this.value, required this.color, this.label});
}

/// A set of hollow providing hollow center, arc segments, and legend mappings natively.
class DonutChartPainter extends StatelessWidget {
  final List<RingData> rings;
  final double strokeWidth;
  final double spacing;

  const DonutChartPainter({
    super.key,
    required this.rings,
    this.strokeWidth = 12.0,
    this.spacing = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DonutChartCustomPainter(
        rings: rings,
        strokeWidth: strokeWidth,
        spacing: spacing,
      ),
    );
  }
}

class _DonutChartCustomPainter extends CustomPainter {
  final List<RingData> rings;
  final double strokeWidth;
  final double spacing;

  _DonutChartCustomPainter({
    required this.rings,
    required this.strokeWidth,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) / 2;

    for (int i = 0; i < rings.length; i++) {
        final ring = rings[i];
        final radius = maxRadius - (i * (strokeWidth + spacing)) - (strokeWidth / 2);
        
        if (radius <= 0) break;

        // Draw background track
        final trackPaint = Paint()
          ..color = ring.color.withValues(alpha: 0.1)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;
        
        canvas.drawCircle(center, radius, trackPaint);

        // Draw progress arc
        final progressPaint = Paint()
          ..color = ring.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

        const startAngle = -math.pi / 2;
        final sweepAngle = 2 * math.pi * ring.value.clamp(0.0, 1.0);

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle,
          false,
          progressPaint,
        );
    }
  }

  @override
  bool shouldRepaint(covariant _DonutChartCustomPainter oldDelegate) {
    return oldDelegate.rings != rings ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.spacing != spacing;
  }
}
