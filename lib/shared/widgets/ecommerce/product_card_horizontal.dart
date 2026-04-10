import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/media/image_kit.dart';
import 'package:flutter_ui_kits/shared/widgets/ecommerce/price_tag.dart';

/// A horizontal product card providing image left and content right layout mappings natively.
class ProductCardHorizontal extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final double? oldPrice;
  final double? rating;
  final int? reviewsCount;
  final VoidCallback? onTap;

  const ProductCardHorizontal({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    this.rating,
    this.reviewsCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.radiusMd,
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.radiusMd,
        child: IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                width: 120,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                  child: ImageKit(imageUrl: imageUrl, width: 120, height: double.infinity),
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      if (rating != null) ...[
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              rating.toString(),
                              style: context.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            if (reviewsCount != null) ...[
                              const SizedBox(width: 4),
                              Text(
                                '($reviewsCount)',
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                      PriceTag(price: price, oldPrice: oldPrice),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
