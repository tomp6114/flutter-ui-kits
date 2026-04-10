import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A set of filter providing price range, categories, and rating mappings natively.
class FilterBottomSheet extends StatefulWidget {
  final double currentMinPrice;
  final double currentMaxPrice;
  final List<String> categories;
  final List<String> selectedCategories;
  final Function(double min, double max, List<String> selected) onApply;

  const FilterBottomSheet({
    super.key,
    required this.currentMinPrice,
    required this.currentMaxPrice,
    required this.categories,
    required this.selectedCategories,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late RangeValues _priceRange;
  late List<String> _tempSelectedCategories;

  @override
  void initState() {
    super.initState();
    _priceRange = RangeValues(widget.currentMinPrice, widget.currentMaxPrice);
    _tempSelectedCategories = List.from(widget.selectedCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Filters',
            style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Price Range (\$${_priceRange.start.round()} - \$${_priceRange.end.round()})',
            style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          RangeSlider(
            values: _priceRange,
            max: 5000,
            divisions: 50,
            activeColor: context.colorScheme.primary,
            onChanged: (values) => setState(() => _priceRange = values),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Categories',
            style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: widget.categories.map((cat) {
              final isSelected = _tempSelectedCategories.contains(cat);
              return FilterChip(
                label: Text(cat),
                selected: isSelected,
                selectedColor: context.colorScheme.primaryContainer,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _tempSelectedCategories.add(cat);
                    } else {
                      _tempSelectedCategories.remove(cat);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),
          ElevatedButton(
            onPressed: () {
              widget.onApply(_priceRange.start, _priceRange.end, _tempSelectedCategories);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Apply Filters', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}
