import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/shared/widgets/layout/blur_container.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';

/// A premium glassmorphism navigation bar providing floating frosted panel effects natively.
class GlassmorphismNavBar extends StatelessWidget {
  /// The index of the currently selected item.
  final int currentIndex;
  /// The list of navigation items.
  final List<BottomNavigationBarItem> items;
  /// Callback executed when an item is tapped.
  final ValueChanged<int>? onTap;
  /// The blur intensity of the background.
  final double blur;
  /// The base color of the panel.
  final Color? color;

  const GlassmorphismNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    this.onTap,
    this.blur = 20.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final panelColor = color ?? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white);
    
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: BlurContainer(
        blur: blur,
        color: panelColor,
        borderRadius: BorderRadius.circular(30),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = index == currentIndex;
            
            return GestureDetector(
              onTap: () => onTap?.call(index),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSelected ? _getSolidIcon(item.icon) : _getOutlineIcon(item.icon),
                      color: isSelected ? Theme.of(context).primaryColor : panelColor.withValues(alpha: 0.5),
                    ),
                    if (item.label != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.label!,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Theme.of(context).primaryColor : panelColor.withValues(alpha: 0.5),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  IconData _getSolidIcon(Widget icon) {
    if (icon is Icon) return icon.icon!;
    return Icons.circle;
  }

  IconData _getOutlineIcon(Widget icon) {
    if (icon is Icon) return icon.icon!;
    return Icons.circle_outlined;
  }
}
