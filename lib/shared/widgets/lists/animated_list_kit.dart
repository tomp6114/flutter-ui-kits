import 'package:flutter/material.dart';

/// A list providing staggered entry animations for children natively seamlessly.
class AnimatedListKit extends StatefulWidget {
  final List<Widget> children;
  final Duration interval;
  final Duration duration;
  final Widget Function(Widget child, Animation<double> animation) builder;

  const AnimatedListKit({
    super.key,
    required this.children,
    this.interval = const Duration(milliseconds: 50),
    this.duration = const Duration(milliseconds: 400),
    this.builder = _defaultBuilder,
  });

  static Widget _defaultBuilder(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutQuart)),
        ),
        child: child,
      ),
    );
  }

  @override
  State<AnimatedListKit> createState() => _AnimatedListKitState();
}

class _AnimatedListKitState extends State<AnimatedListKit> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration + (widget.interval * widget.children.length),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.children.length,
      itemBuilder: (context, index) {
        final double start = (index * widget.interval.inMilliseconds) / _controller.duration!.inMilliseconds;
        final double end = start + (widget.duration.inMilliseconds / _controller.duration!.inMilliseconds);

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final double animValue = (_controller.value - start) / (end - start);
            final double clampedValue = animValue.clamp(0.0, 1.0);
            
            final animation = AlwaysStoppedAnimation(clampedValue);
            return widget.builder(widget.children[index], animation);
          },
        );
      },
    );
  }
}
