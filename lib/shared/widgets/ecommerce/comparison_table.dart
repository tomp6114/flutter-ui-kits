import 'package:flutter/material.dart';

/// A set of specs providing side-by-side product spec comparison mappings natively.
class ComparisonTable extends StatelessWidget {
  final List<String> products;
  final Map<String, List<String>> features;

  const ComparisonTable({
    super.key,
    required this.products,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          const DataColumn(label: Text('Feature', style: TextStyle(fontWeight: FontWeight.bold))),
          ...products.map((p) => DataColumn(label: Text(p, style: const TextStyle(fontWeight: FontWeight.bold)))),
        ],
        rows: features.entries.map((entry) {
          return DataRow(
            cells: [
              DataCell(Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w500))),
              ...entry.value.map((val) => DataCell(Text(val))),
            ],
          );
        }).toList(),
      ),
    );
  }
}
