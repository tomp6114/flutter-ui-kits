import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A data model for a single bar in the [BarChartPainter].
class BarData {
  final double value;
  final String label;
  final Color? color;

  const BarData({required this.value, required this.label, this.color});
}

/// A custom painter providing clean native bar chart mappings natively.
/// A set of bars providing vertical horizontal bars grouped stacked mappings natively.
class BarChartPainter extends StatelessWidget {
  final List<BarData> data;
  final double maxHeight;
  final Color? barColor;

  const BarChartPainter({
    super.key,
    required this.data,
    this.maxHeight = 200.0,
    this.barColor,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = data.map((d) => d.value).reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: maxHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.map((d) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: FractionallySizedBox(
                    heightFactor: d.value / maxValue,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: d.color ?? barColor ?? context.colorScheme.primary,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  d.label,
                  style: context.textTheme.labelSmall?.copyWith(fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
