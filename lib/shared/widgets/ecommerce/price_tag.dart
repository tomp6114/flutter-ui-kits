import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A stylized price display providing direct mapping of current vs old pricing natively.
class PriceTag extends StatelessWidget {
  final double price;
  final double? oldPrice;
  final String currency;
  final TextStyle? priceStyle;

  const PriceTag({
    super.key,
    required this.price,
    this.oldPrice,
    this.currency = '\$',
    this.priceStyle,
  });

  @override
  Widget build(BuildContext context) {
    final double? discount = oldPrice != null && oldPrice! > price
        ? ((oldPrice! - price) / oldPrice! * 100)
        : null;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$currency${price.toStringAsFixed(2)}',
          style: priceStyle ?? context.textTheme.titleLarge?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (oldPrice != null) ...[
          const SizedBox(width: 8),
          Text(
            '$currency${oldPrice!.toStringAsFixed(2)}',
            style: context.textTheme.bodyMedium?.copyWith(
              decoration: TextDecoration.lineThrough,
              color: context.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
        if (discount != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: AppRadius.radiusSm,
            ),
            child: Text(
              '${discount.round()}% OFF',
              style: const TextStyle(
                color: AppColors.success,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
