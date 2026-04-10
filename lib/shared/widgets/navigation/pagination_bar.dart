import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// Ellipsis truncation mapped securely handling page iteration logic.
class PaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;
  final int visiblePageCount; // Number of page dots to show around current page

  const PaginationBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.visiblePageCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox.shrink();

    final List<Widget> items = [];

    // Previous Button
    items.add(
      IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
        color: currentPage > 1 ? context.colorScheme.onSurface : context.colorScheme.onSurface.withValues(alpha: 0.3),
      ),
    );

    // Calculate start and end pages to show
    int startPage = 1;
    int endPage = totalPages;

    if (totalPages > visiblePageCount) {
      final int halfVisible = visiblePageCount ~/ 2;
      startPage = currentPage - halfVisible;
      endPage = currentPage + halfVisible;

      if (startPage < 1) {
        startPage = 1;
        endPage = visiblePageCount;
      } else if (endPage > totalPages) {
        endPage = totalPages;
        startPage = totalPages - visiblePageCount + 1;
      }
    }

    // First page and ellipsis
    if (startPage > 1) {
      items.add(_buildPageItem(context, 1));
      if (startPage > 2) {
        items.add(const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text('...')));
      }
    }

    // Page Numbers
    for (int i = startPage; i <= endPage; i++) {
       items.add(_buildPageItem(context, i));
    }

    // Last page and ellipsis
    if (endPage < totalPages) {
      if (endPage < totalPages - 1) {
        items.add(const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text('...')));
      }
      items.add(_buildPageItem(context, totalPages));
    }

    // Next Button
    items.add(
      IconButton(
        icon: const Icon(Icons.chevron_right),
        onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
        color: currentPage < totalPages ? context.colorScheme.onSurface : context.colorScheme.onSurface.withValues(alpha: 0.3),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }

  Widget _buildPageItem(BuildContext context, int pageNumber) {
    final bool isSelected = pageNumber == currentPage;

    return InkWell(
      onTap: () => onPageChanged(pageNumber),
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        decoration: BoxDecoration(
          color: isSelected ? context.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        alignment: Alignment.center,
        child: Text(
          pageNumber.toString(),
          style: context.textTheme.bodyMedium?.copyWith(
            color: isSelected ? context.colorScheme.onPrimary : context.colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
