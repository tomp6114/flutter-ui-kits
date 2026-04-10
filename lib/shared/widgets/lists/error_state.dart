import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/danger_button.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/button_enums.dart';

/// Predefined layout spanning descriptive boundaries evaluating failure maps natively.
class ErrorState extends StatelessWidget {
  final String title;
  final String description;
  final String? retryLabel;
  final VoidCallback? onRetry;
  final bool isFullScreen;

  const ErrorState({
    super.key,
    this.title = 'Oops! Something went wrong',
    this.description = 'We encountered an error. Please try again later.',
    this.retryLabel = 'Retry',
    this.onRetry,
    this.isFullScreen = true,
  });

  @override
  Widget build(BuildContext context) {
    final Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: isFullScreen ? 80 : 48,
          color: context.colorScheme.error,
        ),
        SizedBox(height: isFullScreen ? AppSpacing.lg : AppSpacing.md),
        Text(
          title,
          style: (isFullScreen ? context.textTheme.headlineSmall : context.textTheme.titleMedium)?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          description,
          style: (isFullScreen ? context.textTheme.bodyLarge : context.textTheme.bodyMedium)?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
        if (retryLabel != null && onRetry != null) ...[
          SizedBox(height: isFullScreen ? AppSpacing.xl : AppSpacing.md),
          DangerButton(
            label: retryLabel!,
            onPressed: onRetry!,
            size: isFullScreen ? ButtonSize.lg : ButtonSize.md,
          ),
        ],
      ],
    );

    if (isFullScreen) {
      return Container(
        color: context.colorScheme.surface,
        padding: const EdgeInsets.all(AppSpacing.xl),
        alignment: Alignment.center,
        child: content,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Center(child: content),
    );
  }
}
