import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// Standard, indeterminate, and lightly animated check bounds seamlessly using native parameters.
class CheckboxKit extends StatelessWidget {
  final bool? value; // True = checked, False = unchecked, Null = indeterminate
  final ValueChanged<bool?> onChanged;
  final String? label;
  final bool isDisabled;

  const CheckboxKit({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          tristate: true,
          onChanged: isDisabled ? null : onChanged,
          activeColor: context.colorScheme.primary,
          checkColor: context.colorScheme.onPrimary,
        ),
        if (label != null) ...[
          GestureDetector(
            onTap: isDisabled
                ? null
                : () {
                    // Tristate toggle logic: false -> true -> null -> false
                    if (value == false) {
                      onChanged(true);
                    } else if (value == true) {
                      onChanged(null);
                    } else {
                      onChanged(false);
                    }
                  },
            child: Text(
              label!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: isDisabled ? context.colorScheme.onSurface.withValues(alpha: 0.5) : context.colorScheme.onSurface,
              ),
            ),
          ),
        ]
      ],
    );
  }
}
