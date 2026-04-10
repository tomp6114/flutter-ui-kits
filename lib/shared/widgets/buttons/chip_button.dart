import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum ChipType { filter, input, action }

/// Specialized chip boundaries handling interaction bounds accurately.
class ChipButtonKit extends StatelessWidget {
  final String label;
  final ChipType type;
  final bool isSelected;
  final VoidCallback? onSelected;
  final VoidCallback? onDeleted;
  final Widget? trailingIcon;
  final Widget? leadingIcon;

  const ChipButtonKit({
    super.key,
    required this.label,
    this.type = ChipType.action,
    this.isSelected = false,
    this.onSelected,
    this.onDeleted,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    if (type == ChipType.filter) {
      return FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: onSelected != null ? (val) => onSelected!() : null,
        backgroundColor: context.colorScheme.surface,
        selectedColor: context.colorScheme.primaryContainer,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.radiusMd),
      );
    } else if (type == ChipType.input) {
      return InputChip(
        label: Text(label),
        onSelected: onSelected != null ? (val) => onSelected!() : null,
        onDeleted: onDeleted,
        avatar: leadingIcon,
        deleteIcon: trailingIcon ?? const Icon(Icons.close, size: 16),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.radiusMd),
      );
    } else {
      return ActionChip(
        label: Text(label),
        onPressed: onSelected,
        avatar: leadingIcon,
        backgroundColor: context.colorScheme.surfaceContainerHighest,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.radiusMd),
      );
    }
  }
}
