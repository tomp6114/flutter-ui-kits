import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/shared/widgets/media/image_kit.dart';

/// A product image carousel providing smooth swipe transitions and dot navigation natively.
class ProductImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double height;
  final bool showIndicators;

  const ProductImageCarousel({
    super.key,
    required this.imageUrls,
    this.height = 300,
    this.showIndicators = true,
  });

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: ClipRRect(
                  borderRadius: AppRadius.radiusMd,
                  child: ImageKit(
                    imageUrl: widget.imageUrls[index],
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),
        if (widget.showIndicators && widget.imageUrls.length > 1) ...[
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.imageUrls.length, (index) {
              final isSelected = _currentIndex == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: isSelected ? 24 : 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}
