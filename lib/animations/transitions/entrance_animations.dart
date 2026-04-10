import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_animations.dart';

/// A set of entrance providing fade-in, slide-up, and staggered entrance mappings natively.
class EntranceAnimations extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;

  const EntranceAnimations({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = AppAnimations.normal,
    this.offset = const Offset(0, 30),
  });

  /// A staggered entrance wrapper for lists.
  static Widget staggered({
    required List<Widget> children,
    Duration interval = const Duration(milliseconds: 100),
  }) {
    return Column(
      children: children.asMap().entries.map((entry) {
        return EntranceAnimations(
          key: ValueKey(entry.key),
          delay: interval * entry.key,
          child: entry.value,
        );
      }).toList(),
    );
  }

  @override
  State<EntranceAnimations> createState() => _EntranceAnimationsState();
}

class _EntranceAnimationsState extends State<EntranceAnimations> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<Offset>(begin: widget.offset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: _slideAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
