import 'package:flutter/material.dart';

/// A set of aurora providing shifting gradient waves background mappings natively.
class AuroraPainter extends CustomPainter {
  final double animationValue;
  final List<Color> colors;

  AuroraPainter({
    required this.animationValue,
    this.colors = const [Colors.tealAccent, Colors.blueAccent, Colors.purpleAccent],
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50);

    for (int i = 0; i < colors.length; i++) {
        final double x = (size.width / (colors.length - 1)) * i;
        final double y = size.height / 2 + (50 * (i % 2 == 0 ? 1 : -1) * (animationValue * 2 - 1));
        
        paint.color = colors[i].withValues(alpha: 0.3);
        canvas.drawCircle(Offset(x, y), 150, paint);
    }
  }

  @override
  bool shouldRepaint(covariant AuroraPainter oldDelegate) => true;
}
