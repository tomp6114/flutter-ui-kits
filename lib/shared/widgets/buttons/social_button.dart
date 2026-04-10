import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum SocialProvider { google, apple, github, facebook }

/// Social media login button structured out generically.
class SocialButton extends StatelessWidget {
  final SocialProvider provider;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;

  const SocialButton({
    super.key,
    required this.provider,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
  });

  String get _label {
    switch (provider) {
      case SocialProvider.google: return 'Continue with Google';
      case SocialProvider.apple: return 'Continue with Apple';
      case SocialProvider.github: return 'Continue with GitHub';
      case SocialProvider.facebook: return 'Continue with Facebook';
    }
  }

  Color get _backgroundColor {
    switch (provider) {
      case SocialProvider.google: return Colors.white;
      case SocialProvider.apple: return Colors.black;
      case SocialProvider.github: return const Color(0xFF24292E);
      case SocialProvider.facebook: return const Color(0xFF1877F2);
    }
  }

  Color get _textColor {
    switch (provider) {
      case SocialProvider.google: return Colors.black87;
      default: return Colors.white;
    }
  }

  Widget _buildIcon() {
    // In a real app we would use unadulterated SVG icons. Here we will mock it 
    // with standard material icon mapping for simplicity.
    IconData iconData;
    switch (provider) {
      case SocialProvider.google: iconData = Icons.g_mobiledata; break;
      case SocialProvider.apple: iconData = Icons.apple; break;
      case SocialProvider.github: iconData = Icons.code; break;
      case SocialProvider.facebook: iconData = Icons.facebook; break;
    }

    return Icon(iconData, color: _textColor, size: 24.0);
  }

  @override
  Widget build(BuildContext context) {
    final bool actuallyDisabled = isDisabled || isLoading || onPressed == null;

    return SizedBox(
      height: 48.0,
      width: double.infinity,
      child: FilledButton(
        onPressed: actuallyDisabled ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: _backgroundColor,
          disabledBackgroundColor: _backgroundColor.withValues(alpha: 0.5),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.radiusMd,
            side: BorderSide(color: AppColors.dividerLight), // standard stroke
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _textColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIcon(),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    _label,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: _textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
