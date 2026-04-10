import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'dart:math';

/// Secure PIN entry matching num-pad interactions natively or standard text, with an error shake animation.
class PinInput extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;
  final bool hasError;

  const PinInput({
    super.key,
    this.length = 4,
    required this.onCompleted,
    this.hasError = false,
  });

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 24).animate(
      CurvedAnimation(parent: _shakeController, curve: const ElasticInCurve()),
    );
    
    _controller.addListener(() {
      setState(() {});
      if (_controller.text.length == widget.length) {
        widget.onCompleted(_controller.text);
      }
    });
  }

  @override
  void didUpdateWidget(PinInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hasError && !oldWidget.hasError) {
      _shakeController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(sin(_shakeAnimation.value * pi) * 8, 0),
          child: child,
        );
      },
      child: GestureDetector(
        onTap: () {
          // Native hidden text field requested to show keyboard
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.length, (index) {
                final isFilled = index < _controller.text.length;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFilled 
                        ? (widget.hasError ? context.colorScheme.error : context.colorScheme.primary) 
                        : Colors.transparent,
                    border: Border.all(
                      color: widget.hasError 
                          ? context.colorScheme.error 
                          : context.colorScheme.onSurface.withValues(alpha: isFilled ? 0.0 : 0.3),
                      width: 2,
                    ),
                  ),
                );
              }),
            ),
            // Hidden text field to capture keyboard simply
            SizedBox(
              height: 0,
              width: 0,
              child: Opacity(
                opacity: 0.0,
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  maxLength: widget.length,
                  autofocus: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
