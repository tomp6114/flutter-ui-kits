import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';

/// A Pinterest-style masonry grid providing variable-height item support naturally natively.
class MasonryGrid extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsets padding;

  const MasonryGrid({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = AppSpacing.md,
    this.crossAxisSpacing = AppSpacing.md,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
  });

  @override
  Widget build(BuildContext context) {
    // Split children into columns to simulate masonry natively without external packages.
    final List<List<Widget>> columns = List.generate(
      crossAxisCount,
      (index) => <Widget>[],
    );

    for (int i = 0; i < children.length; i++) {
      columns[i % crossAxisCount].add(children[i]);
    }

    return SingleChildScrollView(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          crossAxisCount,
          (colIndex) => Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: colIndex == 0 ? 0 : crossAxisSpacing / 2,
                right: colIndex == crossAxisCount - 1 ? 0 : crossAxisSpacing / 2,
              ),
              child: Column(
                children: columns[colIndex].map((item) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: mainAxisSpacing),
                    child: item,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
