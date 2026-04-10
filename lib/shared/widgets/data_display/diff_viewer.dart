import 'package:flutter/material.dart';

/// A native diff providing side-by-side or unified line diff mappings natively.
class DiffViewer extends StatelessWidget {
  final List<DiffLine> lines;

  const DiffViewer({
    super.key,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: lines.map((line) => _buildLine(context, line)).toList(),
      ),
    );
  }

  Widget _buildLine(BuildContext context, DiffLine line) {
    Color? bgColor;
    Color? textColor;
    String prefix = ' ';

    if (line.type == DiffType.added) {
      bgColor = Colors.green.withValues(alpha: 0.1);
      textColor = Colors.green[800];
      prefix = '+';
    } else if (line.type == DiffType.removed) {
      bgColor = Colors.red.withValues(alpha: 0.1);
      textColor = Colors.red[800];
      prefix = '-';
    }

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: Text(
              prefix,
              style: TextStyle(
                color: textColor?.withValues(alpha: 0.6),
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              line.content,
              style: TextStyle(
                color: textColor ?? Colors.black87,
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum DiffType { added, removed, neutral }

class DiffLine {
  final String content;
  final DiffType type;

  DiffLine(this.content, {this.type = DiffType.neutral});
}
