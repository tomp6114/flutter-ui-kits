import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_typography.dart';
import 'package:flutter_ui_kits/shared/widgets/cards/basic_card.dart';

class ActivityItem {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color iconColor;

  ActivityItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.iconColor,
  });
}

class ActivityGroup {
  final String title;
  final List<ActivityItem> items;

  ActivityGroup({required this.title, required this.items});
}

/// A premium activity feed pattern providing grouped chronological list layouts natively.
class ActivityFeed extends StatelessWidget {
  final List<ActivityGroup> groups;

  const ActivityFeed({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groups.map((group) => _buildGroup(context, group)).toList(),
    );
  }

  Widget _buildGroup(BuildContext context, ActivityGroup group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          child: Text(
            group.title,
            style: AppTypography.textTheme.titleSmall?.copyWith(
              color: Colors.grey,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: BasicCard(
            padding: EdgeInsets.zero,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: group.items.length,
              separatorBuilder: (context, index) => const Divider(height: 1, indent: 56),
              itemBuilder: (context, index) {
                final item = group.items[index];
                return ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: item.iconColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item.icon, size: 20, color: item.iconColor),
                  ),
                  title: Text(item.title, style: AppTypography.textTheme.bodyLarge),
                  subtitle: Text(item.subtitle, style: AppTypography.textTheme.bodySmall),
                  trailing: Text(item.time, style: AppTypography.textTheme.labelSmall?.copyWith(color: Colors.grey)),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
