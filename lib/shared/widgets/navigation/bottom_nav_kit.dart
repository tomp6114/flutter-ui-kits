import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum BottomNavVariant { material, bubble }

class BottomNavItem {
  final IconData icon;
  final String label;

  const BottomNavItem({required this.icon, required this.label});
}

/// A wrapper supporting the Material 3 NavigationBar and a custom Animated Bubble variant natively.
class BottomNavKit extends StatelessWidget {
  final List<BottomNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final BottomNavVariant variant;

  const BottomNavKit({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
    this.variant = BottomNavVariant.material,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == BottomNavVariant.bubble) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -2))
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = index == selectedIndex;
              final item = items[index];

              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutQuart,
                  padding: EdgeInsets.symmetric(
                    horizontal: isSelected ? 16.0 : 8.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? context.colorScheme.primary.withValues(alpha: 0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item.icon,
                        color: isSelected ? context.colorScheme.primary : context.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 8.0),
                        Text(
                          item.label,
                          style: context.textTheme.labelLarge?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      );
    }

    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemSelected,
      destinations: items.map((item) {
        return NavigationDestination(
          icon: Icon(item.icon),
          label: item.label,
        );
      }).toList(),
    );
  }
}
