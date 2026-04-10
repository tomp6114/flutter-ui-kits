import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A custom painter providing layered liquid wave background mappings natively.
class WavePainter extends CustomPainter {
  final Color color;
  final double waveAmplitude;
  final double waveFrequency;
  final double wavePhase;
  final double fillPercent;

  WavePainter({
    required this.color,
    this.waveAmplitude = 20.0,
    this.waveFrequency = 0.015,
    this.wavePhase = 0.0,
    this.fillPercent = 0.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    final yBase = size.height * (1 - fillPercent);
    path.moveTo(0, yBase);

    for (double x = 0; x <= size.width; x++) {
        final y = yBase + waveAmplitude * math.sin((x * waveFrequency) + wavePhase);
        path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.waveAmplitude != waveAmplitude ||
        oldDelegate.waveFrequency != waveFrequency ||
        oldDelegate.wavePhase != wavePhase ||
        oldDelegate.fillPercent != fillPercent;
  }
}
