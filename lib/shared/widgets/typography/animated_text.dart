import 'package:flutter/material.dart';

enum AnimatedTextEffect { typewriter, fadeIn, slide }

/// An animated text widget providing typewriter, fade-in, and slide effects natively.
class AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final AnimatedTextEffect effect;
  final Duration duration;
  final bool repeat;

  const AnimatedText(
    this.text, {
    super.key,
    this.style,
    this.effect = AnimatedTextEffect.typewriter,
    this.duration = const Duration(milliseconds: 1500),
    this.repeat = false,
  });

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    if (widget.repeat) {
      _controller.repeat();
    } else {
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
        switch (widget.effect) {
          case AnimatedTextEffect.typewriter:
            final int charCount = (_animation.value * widget.text.length).round();
            return Text(widget.text.substring(0, charCount), style: widget.style);
          case AnimatedTextEffect.fadeIn:
            return Opacity(opacity: _animation.value, child: Text(widget.text, style: widget.style));
          case AnimatedTextEffect.slide:
            return SlideTransition(
              position: Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
                  .animate(_animation),
              child: Opacity(opacity: _animation.value, child: Text(widget.text, style: widget.style)),
            );
        }
      },
    );
  }
}
