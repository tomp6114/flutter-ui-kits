import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/painters/shapes/speech_bubble_painter.dart';

enum PopoverDirection { top, bottom, left, right }

/// An anchored popover with a triangular tail pointing to the trigger.
class PopoverKit extends StatefulWidget {
  final Widget child;
  final Widget content;
  final PopoverDirection direction;
  final Color? backgroundColor;
  final double width;
  final double height;
  final VoidCallback? onDismiss;

  const PopoverKit({
    super.key,
    required this.child,
    required this.content,
    this.direction = PopoverDirection.bottom,
    this.backgroundColor,
    this.width = 200,
    this.height = 100,
    this.onDismiss,
  });

  @override
  State<PopoverKit> createState() => _PopoverKitState();
}

class _PopoverKitState extends State<PopoverKit> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _togglePopover() {
    if (_isOpen) {
      _hidePopover();
    } else {
      _showPopover();
    }
  }

  void _showPopover() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _hidePopover() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
    widget.onDismiss?.call();
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;

    Offset offset;
    ArrowDirection arrowDirection;
    switch (widget.direction) {
      case PopoverDirection.top:
        offset = Offset(0, -widget.height - 12);
        arrowDirection = ArrowDirection.bottom;
        break;
      case PopoverDirection.bottom:
        offset = Offset(0, size.height + 12);
        arrowDirection = ArrowDirection.top;
        break;
      case PopoverDirection.left:
        offset = Offset(-widget.width - 12, 0);
        arrowDirection = ArrowDirection.right;
        break;
      case PopoverDirection.right:
        offset = Offset(size.width + 12, 0);
        arrowDirection = ArrowDirection.left;
        break;
    }

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _hidePopover,
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: offset,
            child: Material(
              color: Colors.transparent,
              child: CustomPaint(
                painter: SpeechBubblePainter(
                  color: widget.backgroundColor ?? context.colorScheme.surface,
                  arrowDirection: arrowDirection,
                ),
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  padding: const EdgeInsets.all(12.0),
                  child: widget.content,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _hidePopover();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _togglePopover,
        child: widget.child,
      ),
    );
  }
}
