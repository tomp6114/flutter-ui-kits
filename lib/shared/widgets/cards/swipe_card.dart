import 'package:flutter/material.dart';
import 'dart:math';

/// Tinder-style swipeable card rendering bounds tracking movement accurately.
class SwipeCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final bool isDraggable;

  const SwipeCard({
    super.key,
    required this.child,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp,
    this.onSwipeDown,
    this.isDraggable = true,
  });

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _dragOffset = Offset.zero;
  double _angle = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    if (!widget.isDraggable) return;
    setState(() {
      _isDragging = true;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!widget.isDraggable) return;
    setState(() {
      _dragOffset += details.delta;
      _angle = (_dragOffset.dx / MediaQuery.of(context).size.width) * (pi / 4); // max 45 deg tilt
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!widget.isDraggable) return;
    setState(() {
      _isDragging = false;
    });

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final escapeThresholdX = screenWidth * 0.3;
    final escapeThresholdY = screenHeight * 0.2;

    if (_dragOffset.dx > escapeThresholdX) {
      _animateOut(Offset(screenWidth, _dragOffset.dy), widget.onSwipeRight);
    } else if (_dragOffset.dx < -escapeThresholdX) {
      _animateOut(Offset(-screenWidth, _dragOffset.dy), widget.onSwipeLeft);
    } else if (_dragOffset.dy < -escapeThresholdY) {
      _animateOut(Offset(_dragOffset.dx, -screenHeight), widget.onSwipeUp);
    } else if (_dragOffset.dy > escapeThresholdY) {
      _animateOut(Offset(_dragOffset.dx, screenHeight), widget.onSwipeDown);
    } else {
      _animateBackToCenter();
    }
  }

  void _animateOut(Offset targetOffset, VoidCallback? callback) {
    final startOffset = _dragOffset;
    final tween = Tween<Offset>(begin: startOffset, end: targetOffset).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    void listener() {
      setState(() {
        _dragOffset = tween.value;
      });
    }

    tween.addListener(listener);
    _controller.forward(from: 0).whenComplete(() {
      tween.removeListener(listener);
      callback?.call();
    });
  }

  void _animateBackToCenter() {
    final startOffset = _dragOffset;
    final tween = Tween<Offset>(begin: startOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    void listener() {
      setState(() {
        _dragOffset = tween.value;
        _angle = (_dragOffset.dx / MediaQuery.of(context).size.width) * (pi / 4);
      });
    }

    tween.addListener(listener);
    _controller.forward(from: 0).whenComplete(() {
      tween.removeListener(listener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform.translate(
        offset: _dragOffset,
        child: Transform.rotate(
          angle: _angle,
          child: widget.child,
        ),
      ),
    );
  }
}
