import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/navigation/bottom_nav_kit.dart'; // Reusing BottomNavItem securely

/// Collapsed side nav expanding lightly visually bounding on hover structurally.
class MiniRail extends StatefulWidget {
  final List<BottomNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final Widget? leading;
  final Widget? trailing;

  const MiniRail({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
    this.leading,
    this.trailing,
  });

  @override
  State<MiniRail> createState() => _MiniRailState();
}

class _MiniRailState extends State<MiniRail> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _isHovered ? 200.0 : 72.0,
        color: context.colorScheme.surface,
        child: Column(
          children: [
            if (widget.leading != null) ...[
              const SizedBox(height: 32),
              widget.leading!,
              const SizedBox(height: 32),
            ],
            Expanded(
              child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  final isSelected = index == widget.selectedIndex;

                  return InkWell(
                    onTap: () => widget.onItemSelected(index),
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      decoration: BoxDecoration(
                        color: isSelected ? context.colorScheme.primary.withValues(alpha: 0.1) : Colors.transparent,
                        border: Border(
                          left: BorderSide(
                            color: isSelected ? context.colorScheme.primary : Colors.transparent,
                            width: 4,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            color: isSelected ? context.colorScheme.primary : context.colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                          if (_isHovered) ...[
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                item.label,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: isSelected ? context.colorScheme.primary : context.colorScheme.onSurface,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (widget.trailing != null) ...[
              widget.trailing!,
              const SizedBox(height: 32),
            ],
          ],
        ),
      ),
    );
  }
}
