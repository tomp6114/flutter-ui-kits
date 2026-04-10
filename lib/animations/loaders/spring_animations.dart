import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// A set of springs providing physics-based bounce-back animation wrappers mappings natively.
class SpringAnimations extends StatefulWidget {
  final Widget child;

  const SpringAnimations({super.key, required this.child});

  @override
  State<SpringAnimations> createState() => _SpringAnimationsState();
}

class _SpringAnimationsState extends State<SpringAnimations> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  Offset _dragOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _animation = _controller.drive(
      Tween<Offset>(begin: Offset.zero, end: Offset.zero),
    );
  }

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      Tween<Offset>(begin: _dragOffset, end: Offset.zero),
    );

    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitsPerSecond.distance);

    _controller.animateWith(simulation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return GestureDetector(
      onPanDown: (details) => _controller.stop(),
      onPanUpdate: (details) {
        setState(() {
          _dragOffset += details.delta;
        });
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final offset = _controller.isAnimating ? _animation.value : _dragOffset;
          return Transform.translate(
            offset: offset,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
