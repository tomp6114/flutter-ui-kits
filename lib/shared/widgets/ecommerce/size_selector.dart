import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A size selector providing S/M/L/XL grid with stock-out strikethrough mappings natively.
class SizeSelector extends StatelessWidget {
  final List<String> sizes;
  final String? selectedSize;
  final List<String> outOfStockSizes;
  final ValueChanged<String> onSizeSelected;

  const SizeSelector({
    super.key,
    required this.sizes,
    this.selectedSize,
    this.outOfStockSizes = const [],
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Size',
          style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: sizes.map((size) {
            final isSelected = size == selectedSize;
            final isOutOfStock = outOfStockSizes.contains(size);

            return InkWell(
              onTap: isOutOfStock ? null : () => onSizeSelected(size),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 54,
                height: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? context.colorScheme.primary : (isOutOfStock ? context.colorScheme.surfaceContainerLow : context.colorScheme.surface),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? context.colorScheme.primary : (isOutOfStock ? Colors.transparent : context.colorScheme.outlineVariant),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      size,
                      style: TextStyle(
                        color: isSelected ? Colors.white : (isOutOfStock ? context.colorScheme.onSurface.withValues(alpha: 0.3) : context.colorScheme.onSurface),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isOutOfStock)
                      Transform.rotate(
                        angle: -0.5,
                        child: Container(
                          width: 40,
                          height: 1,
                          color: context.colorScheme.onSurface.withValues(alpha: 0.3),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
