import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';

/// A snap-to-item horizontal carousel with peak-ahead hints natively.
class HorizontalScrollList extends StatefulWidget {
  final List<Widget> children;
  final double itemWidth;
  final double itemSpacing;
  final ValueChanged<int>? onPageChanged;

  const HorizontalScrollList({
    super.key,
    required this.children,
    this.itemWidth = 300,
    this.itemSpacing = AppSpacing.md,
    this.onPageChanged,
  });

  @override
  State<HorizontalScrollList> createState() => _HorizontalScrollListState();
}

class _HorizontalScrollListState extends State<HorizontalScrollList> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: widget.itemWidth / (widget.itemWidth + widget.itemSpacing),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Default height, should be constrained by parent
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: widget.onPageChanged,
        itemCount: widget.children.length,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);
              }
              return Center(
                child: SizedBox(
                  height: Curves.easeOut.transform(value) * 200,
                  width: widget.itemWidth,
                  child: widget.children[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
