import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A specialized slot for animations providing fallback logic natively.
class LottiePlaceholder extends StatelessWidget {
  final Widget? animation;
  final String? placeholderLabel;

  const LottiePlaceholder({
    super.key,
    this.animation,
    this.placeholderLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (animation != null) return animation!;

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.animation,
            size: 48,
            color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          if (placeholderLabel != null) ...[
            const SizedBox(height: 12),
            Text(
              placeholderLabel!,
              style: context.textTheme.labelLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
