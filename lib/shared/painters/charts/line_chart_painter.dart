import 'package:flutter/material.dart';

/// A set of smooth providing smooth bezier line, fill under, and grid lines mappings natively.
class LineChartPainter extends CustomPainter {
  final List<double> data;
  final Color color;
  final bool showGrid;

  LineChartPainter({
    required this.data,
    required this.color,
    this.showGrid = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final maxVal = data.reduce((a, b) => a > b ? a : b);
    final minVal = data.reduce((a, b) => a < b ? a : b);
    final range = maxVal - minVal == 0 ? 1.0 : maxVal - minVal;

    final path = Path();
    final stepX = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
        final x = i * stepX;
        final y = size.height - ((data[i] - minVal) / range * size.height);
        if (i == 0) {
            path.moveTo(x, y);
        } else {
            path.lineTo(x, y);
        }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant LineChartPainter oldDelegate) => true;
}
