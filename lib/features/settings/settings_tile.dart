import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_typography.dart';

/// A premium settings tile pattern providing icon, title, subtitle, and trailing mappings natively.
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.xxs),
      leading: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: (iconColor ?? Theme.of(context).primaryColor).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppSpacing.sm),
        ),
        child: Icon(icon, size: 22, color: iconColor ?? Theme.of(context).primaryColor),
      ),
      title: Text(
        title,
        style: AppTypography.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTypography.textTheme.bodySmall?.copyWith(color: Colors.grey),
            )
          : null,
      trailing: trailing ?? Icon(Icons.chevron_right, color: Colors.grey.withValues(alpha: 0.5)),
    );
  }
}
