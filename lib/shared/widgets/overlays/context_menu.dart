import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';

class ContextMenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const ContextMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });
}

/// A custom context menu mapping to long-press interactions natively seamlessly.
class ContextMenuKit extends StatefulWidget {
  final Widget child;
  final List<ContextMenuItem> items;
  final double width;

  const ContextMenuKit({
    super.key,
    required this.child,
    required this.items,
    this.width = 220,
  });

  @override
  State<ContextMenuKit> createState() => _ContextMenuKitState();
}

class _ContextMenuKitState extends State<ContextMenuKit> {
  OverlayEntry? _overlayEntry;

  void _showMenu(Offset position) {
    _overlayEntry = _createOverlayEntry(position);
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(Offset position) {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _hideMenu,
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Material(
              elevation: 8,
              borderRadius: AppRadius.radiusMd,
              color: context.colorScheme.surface,
              child: Container(
                width: widget.width,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.items.map((item) {
                    final color = item.isDestructive ? context.colorScheme.error : context.colorScheme.onSurface;
                    return InkWell(
                      onTap: () {
                        _hideMenu();
                        item.onTap();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Icon(item.icon, size: 20, color: color),
                            const SizedBox(width: AppSpacing.md),
                            Text(
                              item.label,
                              style: context.textTheme.bodyLarge?.copyWith(color: color),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) => _showMenu(details.globalPosition),
      child: widget.child,
    );
  }
}
