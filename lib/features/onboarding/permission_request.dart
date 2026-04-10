import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_typography.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/primary_button.dart';

/// A premium permission request pattern providing contextual explanation mappings natively.
class PermissionRequest extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onAllow;
  final VoidCallback onDeny;

  const PermissionRequest({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onAllow,
    required this.onDeny,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 64, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text(
              title,
              style: AppTypography.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              description,
              style: AppTypography.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxxl),
            PrimaryButton(
              label: 'Allow Access',
              onPressed: onAllow,
            ),
            const SizedBox(height: AppSpacing.md),
            TextButton(
              onPressed: onDeny,
              child: const Text('Not Now'),
            ),
          ],
        ),
      ),
    );
  }
}
