import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// Clean logical binary switches wrapped in standard theme aesthetics.
class ToggleButtonKit extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isDisabled;

  const ToggleButtonKit({
    super.key,
    required this.value,
    required this.onChanged,
    this.isDisabled = false,
  });

  @override
  State<ToggleButtonKit> createState() => _ToggleButtonKitState();
}

class _ToggleButtonKitState extends State<ToggleButtonKit> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _circleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

    _circleAnimation = AlignmentTween(
      begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value ? Alignment.centerRight : Alignment.centerLeft,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _colorAnimation = ColorTween(
      begin: context.theme.dividerColor,
      end: context.colorScheme.primary,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void didUpdateWidget(covariant ToggleButtonKit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isDisabled ? null : () => widget.onChanged(!widget.value),
      behavior: HitTestBehavior.opaque,
      child: Opacity(
        opacity: widget.isDisabled ? 0.5 : 1.0,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: 50.0,
              height: 28.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: _colorAnimation.value,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
                child: Container(
                  alignment: _circleAnimation.value,
                  child: Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: widget.value
                        ? Icon(Icons.check, size: 16.0, color: context.colorScheme.primary)
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
