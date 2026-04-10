import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// An animated countdown timer widget providing visual progress and callback natively.
class CountdownTimer extends StatefulWidget {
  final int seconds;
  final VoidCallback onComplete;
  final bool autoStart;
  final Color? color;
  final double size;
  final TextStyle? textStyle;

  const CountdownTimer({
    super.key,
    required this.seconds,
    required this.onComplete,
    this.autoStart = true,
    this.color,
    this.size = 80,
    this.textStyle,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> with SingleTickerProviderStateMixin {
  late AnimationController _sweepController;
  late int _remaining;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _remaining = widget.seconds;
    _sweepController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.seconds),
    );
    if (widget.autoStart) _start();
  }

  void _start() {
    _sweepController.forward();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remaining <= 1) {
        _ticker?.cancel();
        setState(() => _remaining = 0);
        widget.onComplete();
      } else {
        setState(() => _remaining--);
      }
    });
  }

  @override
  void dispose() {
    _sweepController.dispose();
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? context.colorScheme.primary;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Arc progress painter via AnimatedBuilder
          AnimatedBuilder(
            animation: _sweepController,
            builder: (context, _) {
              return CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _ArcPainter(
                  progress: 1.0 - _sweepController.value,
                  color: color,
                  trackColor: color.withValues(alpha: 0.15),
                ),
              );
            },
          ),
          Text(
            '$_remaining',
            style: widget.textStyle ??
                context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color trackColor;

  _ArcPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 4;
    const strokeWidth = 6.0;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Track ring
    canvas.drawCircle(center, radius, trackPaint);

    // Progress arc (starts from top, goes clockwise)
    const startAngle = -3.14159 / 2; // -90 degrees (top)
    final sweepAngle = 2 * 3.14159 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.trackColor != trackColor;
  }
}
