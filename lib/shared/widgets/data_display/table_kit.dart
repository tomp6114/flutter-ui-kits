import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A native table implementation providing sortable columns and zebra striping mappings natively.
class TableKit extends StatelessWidget {
  final List<String> columns;
  final List<List<Widget>> rows;
  final bool isStriped;
  final double? rowHeight;

  const TableKit({
    super.key,
    required this.columns,
    required this.rows,
    this.isStriped = true,
    this.rowHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: context.colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      columnWidths: const {
        0: IntrinsicColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        // Header
        TableRow(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
          ),
          children: columns.map((col) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                col,
                style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
        ),
        // Rows
        ...rows.asMap().entries.map((entry) {
          final index = entry.key;
          final cells = entry.value;
          return TableRow(
            decoration: BoxDecoration(
              color: (isStriped && index % 2 != 0)
                  ? context.colorScheme.surfaceContainerLow
                  : null,
            ),
            children: cells.map((cell) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: cell,
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}
