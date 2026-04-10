import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum RadioKitVariant { standard, card }

/// Radio grouping encompassing multiple interaction bounds.
class RadioKit<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String title;
  final String? subtitle;
  final RadioKitVariant variant;
  final bool isDisabled;

  const RadioKit({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.variant = RadioKitVariant.standard,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    if (variant == RadioKitVariant.card) {
      return GestureDetector(
        onTap: isDisabled ? null : () => onChanged(value),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: isSelected 
                ? context.colorScheme.primary.withValues(alpha: 0.1) 
                : context.colorScheme.surface,
            borderRadius: AppRadius.radiusMd,
            border: Border.all(
              color: isSelected 
                  ? context.colorScheme.primary 
                  : (context.colorScheme.outlineVariant ?? AppColors.dividerLight),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: AppSpacing.xxs),
                      Text(subtitle!, style: context.textTheme.bodySmall),
                    ],
                  ],
                ),
              ),
              Radio<T>(
                value: value,
                groupValue: groupValue,
                onChanged: isDisabled ? null : onChanged,
                activeColor: context.colorScheme.primary,
              ),
            ],
          ),
        ),
      );
    }

    return RadioListTile<T>(
      value: value,
      groupValue: groupValue,
      onChanged: isDisabled ? null : onChanged,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      activeColor: context.colorScheme.primary,
      contentPadding: EdgeInsets.zero,
    );
  }
}
