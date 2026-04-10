import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A recursive tree widget providing structural JSON data visualization natively.
class JsonViewer extends StatelessWidget {
  final dynamic json;
  final int depth;

  const JsonViewer({
    super.key,
    required this.json,
    this.depth = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (json is Map) {
      final map = json as Map;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: map.entries.map((entry) {
          return Padding(
            padding: EdgeInsets.only(left: (depth > 0 ? 16.0 : 0)),
            child: _JsonNode(
              label: entry.key.toString(),
              value: entry.value,
              depth: depth,
            ),
          );
        }).toList(),
      );
    } else if (json is List) {
      final list = json as List;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(list.length, (index) {
          return Padding(
            padding: EdgeInsets.only(left: (depth > 0 ? 16.0 : 0)),
            child: _JsonNode(
              label: '[$index]',
              value: list[index],
              depth: depth,
            ),
          );
        }),
      );
    }
    return Text(json.toString());
  }
}

class _JsonNode extends StatefulWidget {
  final String label;
  final dynamic value;
  final int depth;

  const _JsonNode({
    required this.label,
    required this.value,
    required this.depth,
  });

  @override
  State<_JsonNode> createState() => _JsonNodeState();
}

class _JsonNodeState extends State<_JsonNode> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isComplex = widget.value is Map || widget.value is List;
    final color = _getColorForValue(widget.value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: isComplex ? () => setState(() => _isExpanded = !_isExpanded) : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isComplex)
                Icon(
                  _isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                  size: 20,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                )
              else
                const SizedBox(width: 20),
              Text(
                '${widget.label}: ',
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              ),
              if (!isComplex)
                Expanded(
                  child: Text(
                    widget.value.toString(),
                    style: context.textTheme.bodyMedium?.copyWith(color: color),
                  ),
                )
              else
                Text(
                  widget.value is Map ? '{...}' : '[...]',
                  style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
            ],
          ),
        ),
        if (isComplex && _isExpanded)
          JsonViewer(json: widget.value, depth: widget.depth + 1),
      ],
    );
  }

  Color _getColorForValue(dynamic value) {
    if (value is String) return Colors.green.shade700;
    if (value is num) return Colors.blue.shade700;
    if (value is bool) return Colors.orange.shade700;
    return Colors.black87;
  }
}
