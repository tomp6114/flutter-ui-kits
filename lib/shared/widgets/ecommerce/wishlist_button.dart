import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A heart toggle providing fill animation and wishlist logic mappings natively.
class WishlistButton extends StatefulWidget {
  final bool isLiked;
  final ValueChanged<bool> onChanged;
  final double size;

  const WishlistButton({
    super.key,
    required this.isLiked,
    required this.onChanged,
    this.size = 28.0,
  });

  @override
  State<WishlistButton> createState() => _WishlistButtonState();
}

class _WishlistButtonState extends State<WishlistButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onChanged(!widget.isLiked);
    if (!widget.isLiked) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Icon(
          widget.isLiked ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
          color: widget.isLiked ? Colors.red : context.colorScheme.onSurface.withValues(alpha: 0.4),
          size: widget.size,
        ),
      ),
    );
  }
}
