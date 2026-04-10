import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A production-grade reorderable list kit with drag handle and animated reorder natively.
class ReorderableListKit<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, int, T) itemBuilder;
  final ReorderCallback onReorder;
  final bool showDragHandle;
  final String? header;

  const ReorderableListKit({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onReorder,
    this.showDragHandle = true,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Text(
              header!,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          onReorder: onReorder,
          proxyDecorator: (child, index, animation) {
            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                final double animValue = Curves.easeInOut.transform(animation.value);
                final double elevation = lerpDouble(0, 6, animValue)!;
                return Material(
                  elevation: elevation,
                  color: context.colorScheme.surface,
                  borderRadius: AppRadius.radiusMd,
                  child: child,
                );
              },
              child: child,
            );
          },
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              key: ValueKey(item.hashCode), // Use a stable key
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: context.colorScheme.outlineVariant,
                    width: 0.5,
                  ),
                ),
              ),
              child: ListTile(
                title: itemBuilder(context, index, item),
                trailing: showDragHandle
                    ? ReorderableDragStartListener(
                        index: index,
                        child: Icon(
                          Icons.drag_handle,
                          color: context.colorScheme.onSurface.withValues(alpha: 0.4),
                        ),
                      )
                    : null,
              ),
            );
          },
        ),
      ],
    );
  }
}

// Internal lerp helper for simple double interpolation natively.
double? lerpDouble(num? a, num? b, double t) {
  if (a == null && b == null) return null;
  a ??= 0.0;
  b ??= 0.0;
  return a + (b - a) * t;
}
