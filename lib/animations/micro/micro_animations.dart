import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_animations.dart';

/// A set of micro-animations providing pulse, shake, and bounce widgets mappings natively.
class MicroAnimations {
  /// Pulse animation for attention-grabbing elements.
  static Widget pulse({
    required Widget child,
    bool infinite = true,
  }) {
    return _PulseAnimation(infinite: infinite, child: child);
  }

  /// Shake animation for error feedback.
  static Widget shake({
    required Widget child,
    required Stream<void>? trigger,
  }) {
    return _ShakeAnimation(trigger: trigger, child: child);
  }

  /// Bounce animation for interactive feedback.
  static Widget bounce({
    required Widget child,
    bool isDown = true,
  }) {
    return _BounceAnimation(isDown: isDown, child: child);
  }
}

class _PulseAnimation extends StatefulWidget {
  final Widget child;
  final bool infinite;
  const _PulseAnimation({required this.child, required this.infinite});

  @override
  State<_PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<_PulseAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: AppAnimations.normal);
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    if (widget.infinite) _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation, child: widget.child);
  }
}

class _ShakeAnimation extends StatefulWidget {
  final Widget child;
  final Stream<void>? trigger;
  const _ShakeAnimation({required this.child, this.trigger});

  @override
  State<_ShakeAnimation> createState() => _ShakeAnimationState();
}

class _ShakeAnimationState extends State<_ShakeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    widget.trigger?.listen((_) {
      if (mounted) _controller.forward(from: 0.0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: 0.0), weight: 1),
    ]).animate(_controller);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(offset: Offset(animation.value, 0), child: child);
      },
      child: widget.child,
    );
  }
}

class _BounceAnimation extends StatefulWidget {
  final Widget child;
  final bool isDown;
  const _BounceAnimation({required this.child, required this.isDown});

  @override
  State<_BounceAnimation> createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<_BounceAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: AppAnimations.normal);
    _animation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(scale: _animation, child: widget.child),
    );
  }
}
