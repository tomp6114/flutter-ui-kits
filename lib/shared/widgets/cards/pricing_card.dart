import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/cards/basic_card.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/primary_button.dart';

/// Predefined layout for plan name, price, feature list, and CTA button.
class PricingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String period;
  final List<String> features;
  final String ctaLabel;
  final VoidCallback onCtaPressed;
  final bool isHighlighted;

  const PricingCard({
    super.key,
    required this.title,
    this.subtitle = '',
    required this.price,
    this.period = '/mo',
    required this.features,
    required this.ctaLabel,
    required this.onCtaPressed,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        BasicCard(
          hasBorder: true,
          elevation: isHighlighted ? CardElevation.lg : CardElevation.none,
          backgroundColor: isHighlighted ? context.colorScheme.primary.withValues(alpha: 0.05) : context.colorScheme.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isHighlighted) const SizedBox(height: AppSpacing.sm), // Space for badge
              Text(
                title,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isHighlighted ? context.colorScheme.primary : null,
                ),
                textAlign: TextAlign.center,
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  subtitle,
                  style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface.withValues(alpha: 0.6)),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(price, style: context.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold)),
                  Text(period, style: context.textTheme.titleMedium?.copyWith(color: context.colorScheme.onSurface.withValues(alpha: 0.6))),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                label: ctaLabel,
                onPressed: onCtaPressed,
              ),
              const SizedBox(height: AppSpacing.lg),
              ...features.map((feature) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, size: 20, color: AppColors.success),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(feature, style: context.textTheme.bodyMedium),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        if (isHighlighted)
          Positioned(
            top: -12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4.0),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'MOST POPULAR',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
