import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum SidePanelDirection { left, right }

/// A slide-in side panel mapping to auxiliary tasks like filters or settings.
class SidePanel extends StatefulWidget {
  final Widget child;
  final SidePanelDirection direction;
  final double width;
  final VoidCallback? onDismiss;
  final String? title;

  const SidePanel({
    super.key,
    required this.child,
    this.direction = SidePanelDirection.right,
    this.width = 320,
    this.onDismiss,
    this.title,
  });

  /// static helper to show from the overlay.
  static void show(
    BuildContext context, {
    required Widget child,
    SidePanelDirection direction = SidePanelDirection.right,
    double width = 320,
    VoidCallback? onDismiss,
    String? title,
  }) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => SidePanel(
        direction: direction,
        width: width,
        onDismiss: onDismiss,
        title: title,
        child: child,
      ),
    );
    overlay.insert(entry);
  }

  @override
  State<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    final begin = widget.direction == SidePanelDirection.left ? const Offset(-1, 0) : const Offset(1, 0);
    _offsetAnimation = Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _hide() {
    _controller.reverse().then((_) {
      // In a real app, OverlayEntry must be removed.
      widget.onDismiss?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _hide,
          child: Container(color: Colors.black54),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: widget.direction == SidePanelDirection.left ? 0 : null,
          right: widget.direction == SidePanelDirection.right ? 0 : null,
          child: SlideTransition(
            position: _offsetAnimation,
            child: Material(
              elevation: 16,
              color: context.colorScheme.surface,
              child: SizedBox(
                width: widget.width,
                child: Column(
                  children: [
                    if (widget.title != null) ...[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.title!, style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                            IconButton(icon: const Icon(Icons.close), onPressed: _hide),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                    Expanded(child: widget.child),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
