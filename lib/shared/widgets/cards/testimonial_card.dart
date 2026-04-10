import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/cards/basic_card.dart';

/// Predefined layout for quote, avatar, name, and star rating.
class TestimonialCard extends StatelessWidget {
  final String quote;
  final String name;
  final String title;
  final String avatarUrl;
  final double rating;

  const TestimonialCard({
    super.key,
    required this.quote,
    required this.name,
    this.title = '',
    required this.avatarUrl,
    this.rating = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return BasicCard(
      hasBorder: true,
      elevation: CardElevation.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(5, (index) {
               return Icon(
                 index < rating ? Icons.star : Icons.star_border,
                 color: Colors.amber,
                 size: 16,
               );
             }),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '"$quote"',
            style: context.textTheme.bodyLarge?.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
                backgroundColor: context.colorScheme.primary.withValues(alpha: 0.1),
                child: avatarUrl.isEmpty ? const Icon(Icons.person) : null,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                    if (title.isNotEmpty)
                      Text(title, style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface.withValues(alpha: 0.6))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
