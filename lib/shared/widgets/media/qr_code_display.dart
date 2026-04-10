import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/primary_button.dart';

/// A premium QR display card providing frame styling and quick share actions natively.
class QrCodeDisplay extends StatelessWidget {
  final Widget qrSource; // Expects an image or custom painter widget
  final String? title;
  final String? subtitle;
  final VoidCallback? onShare;

  const QrCodeDisplay({
    super.key,
    required this.qrSource,
    this.title,
    this.subtitle,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // QR Frame
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: qrSource,
          ),
          if (title != null) ...[
            const SizedBox(height: AppSpacing.lg),
            Text(
              title!,
              style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (onShare != null) ...[
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              label: 'Share QR Code',
              onPressed: onShare!,
              leadingIcon: const Icon(Icons.share_outlined, size: 18, color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }
}
