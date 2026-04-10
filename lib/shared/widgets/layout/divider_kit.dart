import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A divider kit providing horizontal and vertical separation with middle label mappings natively.
class DividerKit extends StatelessWidget {
  final String? label;
  final bool isVertical;
  final double thickness;
  final Color? color;
  final double indent;
  final double endIndent;

  const DividerKit({
    super.key,
    this.label,
    this.isVertical = false,
    this.thickness = 1.0,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return VerticalDivider(
        thickness: thickness,
        color: color,
        indent: indent,
        endIndent: endIndent,
      );
    }

    if (label != null) {
      return Row(
        children: [
          Expanded(child: Divider(thickness: thickness, color: color, indent: indent)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              label!,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ),
          Expanded(child: Divider(thickness: thickness, color: color, endIndent: endIndent)),
        ],
      );
    }

    return Divider(
      thickness: thickness,
      color: color,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
