import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/button_enums.dart';

export 'button_enums.dart';

/// A primary filled button using brand colors and standard interaction patterns.
class PrimaryButton extends StatelessWidget {
  /// The text displayed on the button.
  final String label;
  /// Callback executed when the button is pressed.
  final VoidCallback? onPressed;
  /// If true, displays a loading indicator and disables the button.
  final bool isLoading;
  /// If true, visually dims the button and ignores interactions.
  final bool isDisabled;
  /// Standard sizing constraint for the button.
  final ButtonSize size;
  /// Optional widget displayed before the label.
  final Widget? leadingIcon;
  /// Optional widget displayed after the label.
  final Widget? trailingIcon;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = ButtonSize.md,
    this.leadingIcon,
    this.trailingIcon,
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

  EdgeInsets get _padding {
    switch (size) {
      case ButtonSize.sm: return const EdgeInsets.symmetric(horizontal: AppSpacing.md);
      case ButtonSize.md: return const EdgeInsets.symmetric(horizontal: AppSpacing.lg);
      case ButtonSize.lg: return const EdgeInsets.symmetric(horizontal: AppSpacing.xl);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool actuallyDisabled = isDisabled || isLoading || onPressed == null;

    return SizedBox(
      height: _height,
      child: FilledButton(
        onPressed: actuallyDisabled ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: context.colorScheme.primary,
          disabledBackgroundColor: context.colorScheme.primary.withValues(alpha: 0.5),
          padding: _padding,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.radiusMd,
          ),
          textStyle: context.textTheme.labelLarge?.copyWith(
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: _fontSize,
                width: _fontSize,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leadingIcon != null) ...[
                    leadingIcon!,
                    const SizedBox(width: AppSpacing.xs),
                  ],
                  Text(label),
                  if (trailingIcon != null) ...[
                    const SizedBox(width: AppSpacing.xs),
                    trailingIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
