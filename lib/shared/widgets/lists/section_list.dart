import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

class ListSection {
  final String title;
  final List<Widget> items;

  const ListSection({
    required this.title,
    required this.items,
  });
}

/// A list providing sticky headers for categorized items natively.
class SectionList extends StatelessWidget {
  final List<ListSection> sections;
  final ScrollController? controller;
  final bool shrinkWrap;

  const SectionList({
    super.key,
    required this.sections,
    this.controller,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      shrinkWrap: shrinkWrap,
      slivers: sections.expand((section) => [
        _StickyHeaderLayoutDelegate.sliver(
          title: section.title,
          backgroundColor: context.colorScheme.surface,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => section.items[index],
            childCount: section.items.length,
          ),
        ),
      ]).toList(),
    );
  }
}

class _StickyHeaderLayoutDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final Color backgroundColor;

  _StickyHeaderLayoutDelegate({
    required this.title,
    required this.backgroundColor,
  });

  static Widget sliver({required String title, required Color backgroundColor}) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _StickyHeaderLayoutDelegate(title: title, backgroundColor: backgroundColor),
    );
  }

  @override
  double get minExtent => 48.0;

  @override
  double get maxExtent => 48.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 48.0,
      width: double.infinity,
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.colorScheme.primary,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _StickyHeaderLayoutDelegate oldDelegate) {
    return title != oldDelegate.title || backgroundColor != oldDelegate.backgroundColor;
  }
}
