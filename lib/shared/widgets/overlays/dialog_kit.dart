import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/primary_button.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/secondary_button.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/danger_button.dart';
import 'package:flutter_ui_kits/shared/widgets/inputs/text_field_kit.dart';

enum DialogVariant { alert, confirm, prompt }

/// Unified dialog factory managing alert, confirm, and prompt variants securely natively.
class DialogKit {
  /// Simple alert with a single acknowledgment button.
  static Future<void> showAlert(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'OK',
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.radiusLg),
        backgroundColor: context.colorScheme.surface,
        title: Text(title, style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        content: Text(message, style: context.textTheme.bodyMedium),
        actionsPadding: const EdgeInsets.all(AppSpacing.md),
        actions: [
          PrimaryButton(
            label: confirmLabel,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  /// Confirmation dialog returning a boolean.
  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.radiusLg),
        backgroundColor: context.colorScheme.surface,
        title: Text(title, style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        content: Text(message, style: context.textTheme.bodyMedium),
        actionsPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        actions: [
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: cancelLabel,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: isDestructive
                    ? DangerButton(
                        label: confirmLabel,
                        onPressed: () => Navigator.of(context).pop(true),
                      )
                    : PrimaryButton(
                        label: confirmLabel,
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Prompt dialog returning string input securely.
  static Future<String?> showPrompt(
    BuildContext context, {
    required String title,
    String? message,
    String hintText = 'Enter value...',
    String confirmLabel = 'Submit',
    String cancelLabel = 'Cancel',
    String? initialValue,
  }) {
    final TextEditingController controller = TextEditingController(text: initialValue);

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.radiusLg),
        backgroundColor: context.colorScheme.surface,
        title: Text(title, style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message != null) ...[
              Text(message, style: context.textTheme.bodyMedium),
              const SizedBox(height: AppSpacing.md),
            ],
            TextFieldKit(
              controller: controller,
              hint: hintText,
              autofocus: true,
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        actions: [
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: cancelLabel,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: PrimaryButton(
                  label: confirmLabel,
                  onPressed: () => Navigator.of(context).pop(controller.text),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
