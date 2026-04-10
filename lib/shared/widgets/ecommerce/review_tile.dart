import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/media/avatar_kit.dart';

/// A structured reviewer feedback widget providing rating, content, and verification visualization natively.
class ReviewTile extends StatelessWidget {
  final String authorName;
  final String? avatarUrl;
  final double rating;
  final String content;
  final DateTime? date;
  final bool isVerified;

  const ReviewTile({
    super.key,
    required this.authorName,
    this.avatarUrl,
    required this.rating,
    required this.content,
    this.date,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AvatarKit(
              initials: authorName.isNotEmpty ? authorName[0] : '?',
              imageUrl: avatarUrl,
              size: 40,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        authorName,
                        style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (isVerified) ...[
                        const SizedBox(width: 4),
                        Icon(Icons.verified_rounded, size: 14, color: context.colorScheme.primary),
                      ],
                    ],
                  ),
                  Row(
                    children: [
                      _buildStars(context),
                      if (date != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          '•  ${_formatDate(date!)}',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          content,
          style: context.textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
      ],
    );
  }

  Widget _buildStars(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star_rounded : Icons.star_outline_rounded,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
