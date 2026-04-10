import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum SwitchVariant { material, apple, custom }

/// Cross-platform and custom animated thumb switches safely wrapped.
class SwitchKit extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final SwitchVariant variant;
  final bool isDisabled;

  const SwitchKit({
    super.key,
    required this.value,
    required this.onChanged,
    this.variant = SwitchVariant.material,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == SwitchVariant.apple) {
      return Opacity(
        opacity: isDisabled ? 0.5 : 1.0,
        child: IgnorePointer(
          ignoring: isDisabled,
          child: CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: context.colorScheme.primary,
          ),
        ),
      );
    }
    
    if (variant == SwitchVariant.custom) {
      // Reusing logic similar to ToggleButtonKit mapped broadly
      return GestureDetector(
        onTap: isDisabled ? null : () => onChanged(!value),
        child: Opacity(
          opacity: isDisabled ? 0.5 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 50.0,
            height: 28.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: value ? context.colorScheme.primary : context.theme.dividerColor,
            ),
            padding: EdgeInsets.only(
              left: value ? 24.0 : 2.0,
              right: value ? 2.0 : 24.0,
              top: 2.0,
              bottom: 2.0,
            ),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return Switch(
      value: value,
      onChanged: isDisabled ? null : onChanged,
      activeThumbColor: context.colorScheme.primary,
    );
  }
}
