import 'package:flutter/material.dart';

/// A native sticky header Mapping a persistent header logic elegantly natively.
class StickyHeaderLayout extends StatelessWidget {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  const StickyHeaderLayout({
    super.key,
    required this.child,
    this.minHeight = 48.0,
    this.maxHeight = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _StickyHeaderLayoutDelegate(
        minHeight: minHeight,
        maxHeight: maxHeight,
        child: child,
      ),
    );
  }
}

class _StickyHeaderLayoutDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  const _StickyHeaderLayoutDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_StickyHeaderLayoutDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
