import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/cards/basic_card.dart';
import 'package:flutter_ui_kits/shared/widgets/media/image_kit.dart';

enum ProductCardVariant { vertical, horizontal }

/// An e-commerce product card providing visual sales mapping with price, rating, and actions natively.
class ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final double? oldPrice;
  final double rating;
  final int reviewsCount;
  final String? discountLabel;
  final ProductCardVariant variant;
  final VoidCallback? onAddTap;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.discountLabel,
    this.variant = ProductCardVariant.vertical,
    this.onAddTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == ProductCardVariant.horizontal) {
      return _buildHorizontal(context);
    }
    return _buildVertical(context);
  }

  Widget _buildVertical(BuildContext context) {
    return BasicCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.md)),
                child: ImageKit(
                  imageUrl: imageUrl,
                  height: 180,
                  width: double.infinity,
                ),
              ),
              if (discountLabel != null)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: const BoxDecoration(
                      color: AppColors.errorLight,
                      borderRadius: AppRadius.radiusSm,
                    ),
                    child: Text(
                      discountLabel!,
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              Positioned(
                bottom: 8,
                right: 8,
                child: FloatingActionButton.small(
                  onPressed: onAddTap,
                  backgroundColor: context.colorScheme.primary,
                  child: const Icon(Icons.add_shopping_cart_rounded, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '$rating ($reviewsCount)',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: context.textTheme.titleLarge?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (oldPrice != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        '\$${oldPrice!.toStringAsFixed(2)}',
                        style: context.textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: context.colorScheme.onSurface.withValues(alpha: 0.4),
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
    );
  }

  Widget _buildHorizontal(BuildContext context) {
    return BasicCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(AppRadius.md)),
            child: ImageKit(
              imageUrl: imageUrl,
              height: 120,
              width: 120,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${price.toStringAsFixed(2)}',
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (oldPrice != null)
                            Text(
                              '\$${oldPrice!.toStringAsFixed(2)}',
                              style: context.textTheme.bodySmall?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: context.colorScheme.onSurface.withValues(alpha: 0.4),
                              ),
                            ),
                        ],
                      ),
                      IconButton.filled(
                        onPressed: onAddTap,
                        icon: const Icon(Icons.add_shopping_cart_rounded, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
