import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/media/image_kit.dart';

/// A set of small providing horizontal scroll of small product card mappings natively.
class RecentlyViewedList extends StatelessWidget {
  final List<SimpleProduct> products;
  final Function(SimpleProduct p) onTap;

  const RecentlyViewedList({
    super.key,
    required this.products,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recently Viewed',
            style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final p = products[index];
              return InkWell(
                onTap: () => onTap(p),
                borderRadius: AppRadius.radiusMd,
                child: SizedBox(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: AppRadius.radiusMd,
                        child: ImageKit(imageUrl: p.imageUrl, height: 100, width: 100),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        p.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${p.price.toStringAsFixed(2)}',
                        style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SimpleProduct {
  final String title;
  final String imageUrl;
  final double price;

  SimpleProduct({required this.title, required this.imageUrl, required this.price});
}
