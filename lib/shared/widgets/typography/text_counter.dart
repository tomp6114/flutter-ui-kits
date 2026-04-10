import 'package:flutter/material.dart';

/// An animated number counter providing smooth value transitions natively.
class TextCounter extends StatefulWidget {
  final num value;
  final TextStyle? style;
  final Duration duration;
  final String prefix;
  final String suffix;
  final int precision;

  const TextCounter({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 800),
    this.prefix = '',
    this.suffix = '',
    this.precision = 0,
  });

  @override
  State<TextCounter> createState() => _TextCounterState();
}

class _TextCounterState extends State<TextCounter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _oldValue = 0;

  @override
  void initState() {
    super.initState();
    _oldValue = widget.value.toDouble();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: _oldValue, end: _oldValue).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didUpdateWidget(TextCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _oldValue = oldWidget.value.toDouble();
      _animation = Tween<double>(begin: _oldValue, end: widget.value.toDouble()).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final displayValue = _animation.value.toStringAsFixed(widget.precision);
        return Text(
          '${widget.prefix}$displayValue${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }
}
