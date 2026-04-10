import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A set of tickets providing movie/event ticket with circular notches mappings natively.
class TicketPainter extends CustomPainter {
  final Color color;
  final double punchRadius;
  final bool isHorizontal;

  TicketPainter({
    required this.color,
    this.punchRadius = 15.0,
    this.isHorizontal = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    
    path.moveTo(0, 0);
    
    if (isHorizontal) {
        path.lineTo(size.width / 3 - punchRadius, 0);
        path.arcToPoint(Offset(size.width / 3 + punchRadius, 0), radius: Radius.circular(punchRadius));
        path.lineTo(size.width, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(size.width / 3 + punchRadius, size.height);
        path.arcToPoint(Offset(size.width / 3 - punchRadius, size.height), radius: Radius.circular(punchRadius));
        path.lineTo(0, size.height);
    } else {
        path.lineTo(size.width, 0);
        path.lineTo(size.width, size.height / 3 - punchRadius);
        path.arcToPoint(Offset(size.width, size.height / 3 + punchRadius), radius: Radius.circular(punchRadius));
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height);
        path.lineTo(0, size.height / 3 + punchRadius);
        path.arcToPoint(Offset(0, size.height / 3 - punchRadius), radius: Radius.circular(punchRadius));
    }
    path.close();
    canvas.drawPath(path, paint);
    
    // Scissor Line
    final dashPaint = Paint()..color = Colors.black.withValues(alpha: 0.1)..strokeWidth = 1;
    if (isHorizontal) {
        _drawDashedLine(canvas, Offset(size.width / 3, punchRadius), Offset(size.width / 3, size.height - punchRadius), dashPaint);
    } else {
        _drawDashedLine(canvas, Offset(punchRadius, size.height / 3), Offset(size.width - punchRadius, size.height / 3), dashPaint);
    }
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    const double dashWidth = 5.0;
    const double dashSpace = 3.0;
    double distance = 0.0;
    final double totalDistance = (p2 - p1).distance;
    final Offset direction = (p2 - p1) / totalDistance;
    while (distance < totalDistance) {
        canvas.drawLine(p1 + direction * distance, p1 + direction * math.min(distance + dashWidth, totalDistance), paint);
        distance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant TicketPainter oldDelegate) => true;
}


