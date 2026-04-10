import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/button_enums.dart';

/// A ghost button, text-only interactive field triggering hover states.
class GhostButton extends StatelessWidget {
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

  const GhostButton({
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
    final primaryColor = context.colorScheme.primary;

    return SizedBox(
      height: _height,
      child: TextButton(
        onPressed: actuallyDisabled ? null : onPressed,
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          disabledForegroundColor: primaryColor.withValues(alpha: 0.5),
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
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: primaryColor,
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
