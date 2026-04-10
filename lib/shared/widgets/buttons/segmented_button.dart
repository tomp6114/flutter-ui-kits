import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A multi-option toggle that resembles segmented layouts natively.
class SegmentedButtonKit<T> extends StatelessWidget {
  /// Defines segments and labels visually attached.
  final Map<T, String> segments;
  /// Current active/selected key.
  final T selected;
  /// Handler returning when the segment triggers change.
  final ValueChanged<T> onChanged;
  /// Visual width constraint matching the parent or defining rigid behavior.
  final double? width;

  const SegmentedButtonKit({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: context.colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: AppRadius.radiusMd,
        border: Border.all(color: context.colorScheme.outlineVariant ?? AppColors.dividerLight),
      ),
      padding: const EdgeInsets.all(AppSpacing.xxs),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: segments.entries.map((entry) {
          final isSelected = entry.key == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(entry.key),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.md),
                decoration: BoxDecoration(
                  color: isSelected ? context.colorScheme.primary : Colors.transparent,
                  borderRadius: AppRadius.radiusMd,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    entry.value,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: isSelected ? context.colorScheme.onPrimary : context.colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
