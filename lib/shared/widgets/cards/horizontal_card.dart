import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/cards/basic_card.dart';

/// Predefined layout for image left + content right structurally.
class HorizontalCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final Widget? trailing;
  final VoidCallback? onTap;

  const HorizontalCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BasicCard(
      padding: EdgeInsets.zero,
      hasBorder: true,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch, // assuming fixed height context from parent or internal size limits
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppRadius.md),
              bottomLeft: Radius.circular(AppRadius.md),
            ),
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    width: 120,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 120,
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    child: const Icon(Icons.image, size: 40),
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    description,
                    style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface.withValues(alpha: 0.6)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (trailing != null) ...[
                    const Spacer(),
                    trailing!,
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
