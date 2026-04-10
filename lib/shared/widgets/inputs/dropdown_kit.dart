import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// Single select + multi-select + searchable natively configured without external packages overhead.
class DropdownKit<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemAsString;
  final T? selectedItem;
  final List<T> selectedItems;
  final ValueChanged<T?>? onChanged;
  final ValueChanged<List<T>>? onMultiChanged;
  final bool isMultiSelect;
  final bool isSearchable;
  final String hint;

  const DropdownKit({
    super.key,
    required this.items,
    required this.itemAsString,
    this.selectedItem,
    this.selectedItems = const [],
    this.onChanged,
    this.onMultiChanged,
    this.isMultiSelect = false,
    this.isSearchable = false,
    this.hint = 'Select item',
  });

  @override
  State<DropdownKit<T>> createState() => _DropdownKitState<T>();
}

class _DropdownKitState<T> extends State<DropdownKit<T>> {
  final TextEditingController _searchController = TextEditingController();
  List<T> _filteredItems = [];
  late List<T> _currentSelectedItems;
  T? _currentSelected;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _currentSelected = widget.selectedItem;
    _currentSelectedItems = List.from(widget.selectedItems);
    
    _searchController.addListener(() {
      final query = _searchController.text.toLowerCase();
      setState(() {
        _filteredItems = widget.items.where((item) {
          return widget.itemAsString(item).toLowerCase().contains(query);
        }).toList();
      });
    });
  }

  @override
  void didUpdateWidget(DropdownKit<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isMultiSelect && widget.selectedItem != oldWidget.selectedItem) {
      _currentSelected = widget.selectedItem;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.isSearchable) ...[
                    TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: AppRadius.radiusMd),
                      ),
                      onChanged: (val) {
                        setModalState(() {});
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        final isSelected = widget.isMultiSelect
                            ? _currentSelectedItems.contains(item)
                            : _currentSelected == item;

                        return ListTile(
                          title: Text(widget.itemAsString(item)),
                          trailing: isSelected ? const Icon(Icons.check, color: AppColors.primary) : null,
                          onTap: () {
                            if (widget.isMultiSelect) {
                              setModalState(() {
                                if (isSelected) {
                                  _currentSelectedItems.remove(item);
                                } else {
                                  _currentSelectedItems.add(item);
                                }
                              });
                              setState(() {});
                              widget.onMultiChanged?.call(_currentSelectedItems);
                            } else {
                              setState(() {
                                _currentSelected = item;
                              });
                              widget.onChanged?.call(item);
                              Navigator.pop(context);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showModal,
      borderRadius: AppRadius.radiusMd,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 14.0),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outlineVariant ?? AppColors.dividerLight),
          borderRadius: AppRadius.radiusMd,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.isMultiSelect
                    ? (_currentSelectedItems.isEmpty ? widget.hint : _currentSelectedItems.map((e) => widget.itemAsString(e)).join(', '))
                    : (_currentSelected != null ? widget.itemAsString(_currentSelected as T) : widget.hint),
                style: context.textTheme.bodyLarge?.copyWith(
                  color: (widget.isMultiSelect ? _currentSelectedItems.isEmpty : _currentSelected == null)
                      ? context.colorScheme.onSurface.withValues(alpha: 0.5)
                      : context.colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
