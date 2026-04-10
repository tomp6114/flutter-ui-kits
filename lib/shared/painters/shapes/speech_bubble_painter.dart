import 'package:flutter/material.dart';

enum ArrowDirection { top, bottom, left, right }

/// A painter that draws a rounded rectangle with a triangular tail.
class SpeechBubblePainter extends CustomPainter {
  final Color color;
  final double borderRadius;
  final double arrowSize;
  final ArrowDirection arrowDirection;
  final Offset arrowOffset;

  SpeechBubblePainter({
    required this.color,
    this.borderRadius = 12.0,
    this.arrowSize = 12.0,
    this.arrowDirection = ArrowDirection.bottom,
    this.arrowOffset = Offset.zero,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rect);

    // Calculate arrow path
    final arrowPath = Path();
    switch (arrowDirection) {
      case ArrowDirection.bottom:
        final centerX = size.width / 2 + arrowOffset.dx;
        arrowPath.moveTo(centerX - arrowSize, size.height);
        arrowPath.lineTo(centerX, size.height + arrowSize);
        arrowPath.lineTo(centerX + arrowSize, size.height);
        break;
      case ArrowDirection.top:
        final centerX = size.width / 2 + arrowOffset.dx;
        arrowPath.moveTo(centerX - arrowSize, 0);
        arrowPath.lineTo(centerX, -arrowSize);
        arrowPath.lineTo(centerX + arrowSize, 0);
        break;
      case ArrowDirection.left:
        final centerY = size.height / 2 + arrowOffset.dy;
        arrowPath.moveTo(0, centerY - arrowSize);
        arrowPath.lineTo(-arrowSize, centerY);
        arrowPath.lineTo(0, centerY + arrowSize);
        break;
      case ArrowDirection.right:
        final centerY = size.height / 2 + arrowOffset.dy;
        arrowPath.moveTo(size.width, centerY - arrowSize);
        arrowPath.lineTo(size.width + arrowSize, centerY);
        arrowPath.lineTo(size.width, centerY + arrowSize);
        break;
    }
    arrowPath.close();
    path.addPath(arrowPath, Offset.zero);

    canvas.drawShadow(path, Colors.black, 4.0, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SpeechBubblePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.arrowSize != arrowSize ||
        oldDelegate.arrowDirection != arrowDirection ||
        oldDelegate.arrowOffset != arrowOffset;
  }
}
