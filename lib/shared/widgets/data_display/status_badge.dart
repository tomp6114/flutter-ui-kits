import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum StatusType { success, error, warning, info, neutral }

/// A semantic badge providing status visualization with colors and icons natively.
class StatusBadge extends StatelessWidget {
  final String label;
  final StatusType type;
  final bool hasDot;
  final IconData? icon;

  const StatusBadge({
    super.key,
    required this.label,
    this.type = StatusType.neutral,
    this.hasDot = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Color color;
    switch (type) {
      case StatusType.success: color = AppColors.success; break;
      case StatusType.error: color = AppColors.errorLight; break;
      case StatusType.warning: color = Colors.orange; break;
      case StatusType.info: color = AppColors.secondary; break;
      case StatusType.neutral: color = context.colorScheme.onSurface.withValues(alpha: 0.5); break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadius.radiusPill,
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasDot) ...[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
