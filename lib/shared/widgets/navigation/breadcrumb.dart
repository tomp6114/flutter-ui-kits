import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

class BreadcrumbItem {
  final String label;
  final VoidCallback? onTap;

  const BreadcrumbItem({required this.label, this.onTap});
}

/// Dynamic path trail supporting truncation logically cleanly wrapping separators.
class BreadcrumbKit extends StatelessWidget {
  final List<BreadcrumbItem> items;
  final Widget separator;
  final int maxItemsBeforeTruncate;

  const BreadcrumbKit({
    super.key,
    required this.items,
    this.separator = const Icon(Icons.chevron_right, size: 16),
    this.maxItemsBeforeTruncate = 4,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final List<Widget> rowChildren = [];
    final bool needsTruncation = items.length > maxItemsBeforeTruncate;

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final isLast = i == items.length - 1;

      if (needsTruncation && i > 0 && i < items.length - 2) {
        if (i == 1) {
          rowChildren.add(
            Text('...', style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface.withValues(alpha: 0.5))),
          );
          rowChildren.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: separator,
          ));
        }
        continue; // skip the rest of middle elements
      }

      rowChildren.add(
        InkWell(
          onTap: isLast ? null : item.onTap,
          child: Text(
            item.label,
            style: context.textTheme.bodyMedium?.copyWith(
              color: isLast ? context.colorScheme.onSurface : context.colorScheme.primary,
              fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      );

      if (!isLast) {
        rowChildren.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: separator,
          ),
        );
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: rowChildren,
      ),
    );
  }
}
