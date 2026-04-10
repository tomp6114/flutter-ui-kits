import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum SnackbarVariant { info, success, warning, error }

/// Floating bounds mapped against native ScaffoldMessenger safely parsing variants dynamically.
class SnackbarKit {
  static void show(
    BuildContext context, {
    required String message,
    SnackbarVariant variant = SnackbarVariant.info,
    bool isFloating = true,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();

    Color backgroundColor;
    Color textColor = Colors.white;
    IconData icon;

    switch (variant) {
      case SnackbarVariant.info:
        backgroundColor = AppColors.info;
        icon = Icons.info_outline;
        break;
      case SnackbarVariant.success:
        backgroundColor = AppColors.success;
        icon = Icons.check_circle_outline;
        break;
      case SnackbarVariant.warning:
        backgroundColor = AppColors.warning;
        textColor = Colors.black87;
        icon = Icons.warning_amber_rounded;
        break;
      case SnackbarVariant.error:
        backgroundColor = context.colorScheme.error;
        icon = Icons.error_outline;
        break;
    }

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: textColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: context.textTheme.bodyMedium?.copyWith(color: textColor),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
        shape: isFloating ? const RoundedRectangleBorder(borderRadius: AppRadius.radiusMd) : null,
        margin: isFloating ? const EdgeInsets.all(16.0) : null,
        duration: duration,
        action: actionLabel != null && onAction != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: textColor,
                onPressed: onAction,
              )
            : null,
      ),
    );
  }
}
