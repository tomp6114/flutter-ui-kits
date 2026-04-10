import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/button_enums.dart';

/// Extracting purely rounded pill variants visually.
class PillButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final ButtonSize size;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool isOutlined;

  const PillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = ButtonSize.md,
    this.leadingIcon,
    this.trailingIcon,
    this.isOutlined = false,
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

    if (isOutlined) {
      return SizedBox(
        height: _height,
        child: OutlinedButton(
          onPressed: actuallyDisabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            disabledForegroundColor: primaryColor.withValues(alpha: 0.5),
            side: BorderSide(
              color: actuallyDisabled ? primaryColor.withValues(alpha: 0.5) : primaryColor,
            ),
            padding: _padding,
            shape: const RoundedRectangleBorder(
              borderRadius: AppRadius.radiusPill,
            ),
            textStyle: context.textTheme.labelLarge?.copyWith(
              fontSize: _fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: _buildContent(primaryColor),
        ),
      );
    }

    return SizedBox(
      height: _height,
      child: FilledButton(
        onPressed: actuallyDisabled ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: primaryColor,
          disabledBackgroundColor: primaryColor.withValues(alpha: 0.5),
          padding: _padding,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.radiusPill,
          ),
          textStyle: context.textTheme.labelLarge?.copyWith(
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: _buildContent(context.colorScheme.onPrimary),
      ),
    );
  }

  Widget _buildContent(Color loaderColor) {
    if (isLoading) {
      return SizedBox(
        height: _fontSize,
        width: _fontSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: loaderColor,
        ),
      );
    }
    return Row(
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
    );
  }
}
