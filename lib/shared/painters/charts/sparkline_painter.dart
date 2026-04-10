import 'package:flutter/material.dart';

/// A set of compact providing smooth bezier line, fill under, and grid lines mappings natively.
class SparklinePainter extends StatelessWidget {
  final List<double> data;
  final Color color;
  final double strokeWidth;
  final bool fill;

  const SparklinePainter({
    super.key,
    required this.data,
    this.color = Colors.blue,
    this.strokeWidth = 2.0,
    this.fill = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SparklineCustomPainter(
        data: data,
        color: color,
        strokeWidth: strokeWidth,
        fill: fill,
      ),
    );
  }
}

class _SparklineCustomPainter extends CustomPainter {
  final List<double> data;
  final Color color;
  final double strokeWidth;
  final bool fill;

  _SparklineCustomPainter({
    required this.data,
    required this.color,
    required this.strokeWidth,
    required this.fill,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final maxValue = data.reduce((a, b) => a > b ? a : b);
    final minValue = data.reduce((a, b) => a < b ? a : b);
    final range = (maxValue - minValue) == 0 ? 1.0 : (maxValue - minValue);

    final path = Path();
    final widthStep = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
        final x = i * widthStep;
        final y = size.height - ((data[i] - minValue) / range * size.height);
        
        if (i == 0) {
            path.moveTo(x, y);
        } else {
            path.lineTo(x, y);
        }
    }

    if (fill) {
        final fillPath = Path.from(path);
        fillPath.lineTo(size.width, size.height);
        fillPath.lineTo(0, size.height);
        fillPath.close();

        final fillPaint = Paint()
          ..color = color.withValues(alpha: 0.1)
          ..style = PaintingStyle.fill;
        
        canvas.drawPath(fillPath, fillPaint);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SparklineCustomPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.fill != fill;
  }
}
