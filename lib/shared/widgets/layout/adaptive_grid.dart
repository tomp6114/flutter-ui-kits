import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/responsive.dart';

/// A grid providing automatic column count mapping from screen width natively.
class AdaptiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int mobileCols;
  final int tabletCols;
  final int desktopCols;
  final double spacing;

  const AdaptiveGrid({
    super.key,
    required this.children,
    this.mobileCols = 1,
    this.tabletCols = 2,
    this.desktopCols = 3,
    this.spacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    int cols;
    if (Responsive.isDesktop(context)) {
      cols = desktopCols;
    } else if (Responsive.isTablet(context)) {
      cols = tabletCols;
    } else {
      cols = mobileCols;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - (spacing * (cols - 1))) / cols;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: children.map((child) => SizedBox(width: itemWidth, child: child)).toList(),
        );
      },
    );
  }
}
