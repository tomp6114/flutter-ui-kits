import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/responsive.dart';

/// A flexible adaptive grid system Mapping column counts to breakpoints elegantly natively.
class AdaptiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double spacing;
  final double runSpacing;

  const AdaptiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns;
        if (Responsive.isDesktop(context)) {
          columns = desktopColumns;
        } else if (Responsive.isTablet(context)) {
          columns = tabletColumns;
        } else {
          columns = mobileColumns;
        }

        final double width = (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: children.map((child) {
            return SizedBox(
              width: width,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }
}
