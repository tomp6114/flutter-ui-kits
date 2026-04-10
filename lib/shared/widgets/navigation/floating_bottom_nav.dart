import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/navigation/bottom_nav_kit.dart'; // Reuse the structural item

/// Floating card with centered animated bounds tracking selections natively.
class FloatingBottomNav extends StatelessWidget {
  final List<BottomNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const FloatingBottomNav({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0, left: 24.0, right: 24.0),
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(30.0),
        color: context.colorScheme.surface,
        shadowColor: context.colorScheme.shadow.withValues(alpha: 0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Typically centered or expanded
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(items.length, (index) {
              final isSelected = index == selectedIndex;
              final item = items[index];

              return InkWell(
                onTap: () => onItemSelected(index),
                customBorder: const CircleBorder(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: isSelected ? context.colorScheme.primary : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.icon,
                    color: isSelected ? context.colorScheme.onPrimary : context.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
