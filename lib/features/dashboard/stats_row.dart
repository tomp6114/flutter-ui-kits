import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/shared/widgets/cards/stat_card.dart';

/// A premium stats row pattern providing responsive metric card layouts natively.
class StatsRow extends StatelessWidget {
  final List<StatCard> stats;
  final double spacing;

  const StatsRow({
    super.key,
    required this.stats,
    this.spacing = AppSpacing.md,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Row(
        children: stats.asMap().entries.map((entry) {
          final isLast = entry.key == stats.length - 1;
          return Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : spacing),
            child: SizedBox(
              width: 280, // Optimized for mobile viewport
              child: entry.value,
            ),
          );
        }).toList(),
      ),
    );
  }
}
