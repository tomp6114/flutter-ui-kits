import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';

/// A grid allowing mixed tile sizes (staggered patterns) natively seamlessly.
class StaggeredGrid extends StatelessWidget {
  final List<StaggeredTile> children;
  final int crossAxisCount;
  final double spacing;
  final EdgeInsets padding;

  const StaggeredGrid({
    super.key,
    required this.children,
    this.crossAxisCount = 4,
    this.spacing = AppSpacing.md,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double cellWidth = (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
          
          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: children.map((tile) {
              final double width = (cellWidth * tile.crossAxisCellCount) + (spacing * (tile.crossAxisCellCount - 1));
              final double height = (cellWidth * tile.mainAxisCellCount) + (spacing * (tile.mainAxisCellCount - 1));
              
              return SizedBox(
                width: width,
                height: height,
                child: tile.child,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class StaggeredTile {
  final Widget child;
  final int crossAxisCellCount;
  final int mainAxisCellCount;

  const StaggeredTile({
    required this.child,
    this.crossAxisCellCount = 1,
    this.mainAxisCellCount = 1,
  });
}
