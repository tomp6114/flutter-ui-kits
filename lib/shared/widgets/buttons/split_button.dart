import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/button_enums.dart';

/// Compound actions integrating a core clickable context adjacent to a dropdown chevron mechanic.
class SplitButton extends StatelessWidget {
  final String label;
  final VoidCallback onClick;
  final VoidCallback onDropdownClick;
  final bool isDisabled;
  final ButtonSize size;

  const SplitButton({
    super.key,
    required this.label,
    required this.onClick,
    required this.onDropdownClick,
    this.isDisabled = false,
    this.size = ButtonSize.md,
  });

  double get _height {
    switch (size) {
      case ButtonSize.sm: return 36.0;
      case ButtonSize.md: return 48.0;
      case ButtonSize.lg: return 56.0;
    }
  }

  double get _fontSize {
    switch (size) {
      case ButtonSize.sm: return 14.0;
      case ButtonSize.md: return 16.0;
      case ButtonSize.lg: return 18.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: double.infinity,
            child: FilledButton(
              onPressed: isDisabled ? null : onClick,
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(AppRadius.md),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                textStyle: context.textTheme.labelLarge?.copyWith(
                  fontSize: _fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: Text(label),
            ),
          ),
          const SizedBox(width: 1), // 1px separator
          SizedBox(
            height: double.infinity,
            width: _height, // make it square-ish
            child: FilledButton(
              onPressed: isDisabled ? null : onDropdownClick,
              style: FilledButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(AppRadius.md), // Using same radius but for right side
                  ),
                ),
              ),
              child: const Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ],
      ),
    );
  }
}
