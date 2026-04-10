import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A column definition for [DataTableKit] providing label and alignment mappings.
class DataColumnKit {
  final String label;
  final bool isNumeric;
  final double? width;

  const DataColumnKit({
    required this.label,
    this.isNumeric = false,
    this.width,
  });
}

/// A row definition for [DataTableKit] containing cell widgets.
class DataRowKit {
  final List<Widget> cells;
  final VoidCallback? onTap;

  const DataRowKit({required this.cells, this.onTap});
}

/// A high-fidelity data table providing clean header pinning and row interaction models natively.
class DataTableKit extends StatelessWidget {
  final List<DataColumnKit> columns;
  final List<DataRowKit> rows;
  final double rowHeight;
  final double headerHeight;

  const DataTableKit({
    super.key,
    required this.columns,
    required this.rows,
    this.rowHeight = 52.0,
    this.headerHeight = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          height: headerHeight,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Row(
            children: columns.map((col) {
              return Expanded(
                flex: col.width == null ? 1 : 0,
                child: Container(
                  width: col.width,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  alignment: col.isNumeric ? Alignment.centerRight : Alignment.centerLeft,
                  child: Text(
                    col.label,
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const Divider(height: 1),
        // Rows
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rows.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final row = rows[index];
            return InkWell(
              onTap: row.onTap,
              child: SizedBox(
                height: rowHeight,
                child: Row(
                  children: List.generate(columns.length, (colIndex) {
                    final col = columns[colIndex];
                    final cell = row.cells[colIndex];
                    return Expanded(
                      flex: col.width == null ? 1 : 0,
                      child: Container(
                        width: col.width,
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        alignment: col.isNumeric ? Alignment.centerRight : Alignment.centerLeft,
                        child: DefaultTextStyle(
                          style: context.textTheme.bodyMedium!,
                          child: cell,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
