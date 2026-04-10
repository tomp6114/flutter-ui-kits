import 'package:flutter/material.dart';

/// A set of receipts providing zig-zag edge receipt paper mappings natively.
class ReceiptPainter extends CustomPainter {
  final Color color;
  final double zigZagHeight;
  final int zigZagCount;

  ReceiptPainter({
    required this.color,
    this.zigZagHeight = 6.0,
    this.zigZagCount = 20,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    
    path.moveTo(0, zigZagHeight);
    
    // Top zig-zags
    final step = size.width / zigZagCount;
    for (int i = 0; i < zigZagCount; i++) {
        path.lineTo(step * i + step / 2, 0);
        path.lineTo(step * (i + 1), zigZagHeight);
    }
    
    path.lineTo(size.width, size.height - zigZagHeight);
    
    // Bottom zig-zags
    for (int i = zigZagCount; i > 0; i--) {
        path.lineTo(step * i - step / 2, size.height);
        path.lineTo(step * (i - 1), size.height - zigZagHeight);
    }
    
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ReceiptPainter oldDelegate) => true;
}
