import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A contribution-style activity heatmap providing intensity-based visualization natively.
class HeatmapCalendar extends StatelessWidget {
  final Map<DateTime, int> datasets;
  final Color? color;
  final int levels;
  final double cellSize;
  final double spacing;

  const HeatmapCalendar({
    super.key,
    required this.datasets,
    this.color,
    this.levels = 5,
    this.cellSize = 12.0,
    this.spacing = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = color ?? context.colorScheme.primary;
    
    // Calculate date range for the last 52 weeks
    final today = DateTime.now();
    final firstDay = today.subtract(const Duration(days: 364));
    
    // Group into weeks
    final List<List<DateTime>> weeks = [];
    List<DateTime> currentWeek = [];
    
    for (int i = 0; i <= 364; i++) {
        final date = DateTime(firstDay.year, firstDay.month, firstDay.day + i);
        currentWeek.add(date);
        if (date.weekday == DateTime.sunday || i == 364) {
            weeks.add(currentWeek);
            currentWeek = [];
        }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: weeks.map((week) {
          return Padding(
            padding: EdgeInsets.only(right: spacing),
            child: Column(
              children: List.generate(7, (index) {
                // Find date for this day of the week in this week group
                // weekday starts at 1 (Mon) to 7 (Sun)
                final targetWeekday = index + 1;
                final date = week.cast<DateTime?>().firstWhere(
                  (d) => d?.weekday == targetWeekday,
                  orElse: () => null,
                );

                if (date == null) {
                  return SizedBox(width: cellSize, height: cellSize + spacing);
                }

                final count = datasets[DateTime(date.year, date.month, date.day)] ?? 0;
                final opacity = _getOpacityForCount(count, levels);

                return Container(
                  width: cellSize,
                  height: cellSize,
                  margin: EdgeInsets.only(bottom: spacing),
                  decoration: BoxDecoration(
                    color: baseColor.withValues(alpha: count == 0 ? 0.05 : opacity),
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
            ),
          );
        }).toList(),
      ),
    );
  }

  double _getOpacityForCount(int count, int maxLevels) {
    if (count == 0) return 0.05;
    // Simple interpolation for demo purposes
    final level = (count / maxLevels).clamp(0.2, 1.0);
    return level;
  }
}
