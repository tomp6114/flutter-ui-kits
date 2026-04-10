import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/button_enums.dart';

/// Linear gradient fill, simmer on press.
class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final ButtonSize size;
  final List<Color> gradientColors;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.gradientColors,
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

    return Opacity(
      opacity: actuallyDisabled ? 0.5 : 1.0,
      child: Container(
        height: _height,
        decoration: BoxDecoration(
          borderRadius: AppRadius.radiusMd,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withValues(alpha: 0.3),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: actuallyDisabled ? null : onPressed,
            borderRadius: AppRadius.radiusMd,
            child: Padding(
              padding: _padding,
              child: Center(
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
                          Text(
                            label,
                            style: context.textTheme.labelLarge?.copyWith(
                              fontSize: _fontSize,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          if (trailingIcon != null) ...[
                            const SizedBox(width: AppSpacing.xs),
                            trailingIcon!,
                          ],
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
