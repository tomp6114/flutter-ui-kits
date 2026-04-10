import 'package:flutter/material.dart';

/// A list providing automatic grouping by headers based on a groupBy function natively.
class GroupedList<T, G> extends StatelessWidget {
  final List<T> items;
  final G Function(T) groupBy;
  final Widget Function(BuildContext, G) groupHeaderBuilder;
  final Widget Function(BuildContext, T) itemBuilder;
  final int Function(G, G)? groupSeparatorOrder;

  const GroupedList({
    super.key,
    required this.items,
    required this.groupBy,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    this.groupSeparatorOrder,
  });

  @override
  Widget build(BuildContext context) {
    // Sort and group items natively without external packages.
    final Map<G, List<T>> groups = {};
    for (var item in items) {
      final G groupValue = groupBy(item);
      if (!groups.containsKey(groupValue)) {
        groups[groupValue] = [];
      }
      groups[groupValue]!.add(item);
    }

    final List<G> sortedHeaders = groups.keys.toList();
    if (groupSeparatorOrder != null) {
      sortedHeaders.sort(groupSeparatorOrder);
    }

    return ListView.builder(
      itemCount: sortedHeaders.length,
      itemBuilder: (context, headerIndex) {
        final G headerValue = sortedHeaders[headerIndex];
        final List<T> groupItems = groups[headerValue]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            groupHeaderBuilder(context, headerValue),
            ...groupItems.map((item) => itemBuilder(context, item)),
          ],
        );
      },
    );
  }
}
