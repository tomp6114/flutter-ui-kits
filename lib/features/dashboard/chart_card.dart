import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_typography.dart';
import 'package:flutter_ui_kits/shared/widgets/cards/basic_card.dart';

/// A premium dashboard card Providing chart containers and headers mappings natively.
class ChartCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget chart;
  final Widget? legend;
  final List<Widget>? actions;

  const ChartCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.chart,
    this.legend,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return BasicCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: AppTypography.textTheme.bodySmall?.copyWith(color: Colors.grey),
                      ),
                  ],
                ),
              ),
              if (actions != null) Row(children: actions!),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: chart,
          ),
          if (legend != null) ...[
            const SizedBox(height: AppSpacing.lg),
            legend!,
          ],
        ],
      ),
    );
  }
}
