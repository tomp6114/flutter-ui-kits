import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
// Note: In a real project you'd use external packages for actual file picking.
// Since external packages are disabled, this represents purely the visual target area securely.

/// A generalized target area representing a file upload mechanism visually.
class FileUploadField extends StatelessWidget {
  final VoidCallback onTap;
  final double progress; // 0.0 to 1.0 (1.0 = complete, 0.0 = waiting)
  final String? fileName;
  final bool isError;
  final String errorText;

  const FileUploadField({
    super.key,
    required this.onTap,
    this.progress = 0.0,
    this.fileName,
    this.isError = false,
    this.errorText = '',
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = isError ? context.colorScheme.error : context.colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: themeColor.withValues(alpha: 0.05),
          borderRadius: AppRadius.radiusMd,
          border: Border.all(
            color: themeColor.withValues(alpha: 0.3),
            width: 2.0,
          ),
        ),
        child: Column(
          children: [
            Icon(
              fileName == null ? Icons.cloud_upload_outlined : Icons.insert_drive_file,
              size: 48,
              color: themeColor,
            ),
            const SizedBox(height: 16.0),
            if (fileName != null) ...[
              Text(fileName!, style: context.textTheme.bodyLarge, textAlign: TextAlign.center),
              if (progress > 0.0 && progress < 1.0) ...[
                const SizedBox(height: 8.0),
                LinearProgressIndicator(value: progress, color: themeColor),
              ],
            ] else ...[
              Text('Tap or drag files here to upload', style: context.textTheme.bodyLarge),
            ],
            if (isError) ...[
              const SizedBox(height: 8.0),
              Text(errorText, style: context.textTheme.labelSmall?.copyWith(color: themeColor)),
            ],
          ],
        ),
      ),
    );
  }
}
