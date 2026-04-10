import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum FABType { standard, extended, mini }

/// A standard + extended + mini FAB robust logic component.
class FloatingActionButtonKit extends StatelessWidget {
  /// Executed when pressed.
  final VoidCallback onPressed;
  /// The center icon widget.
  final Widget icon;
  /// If extended type is used, displays the string label.
  final String? label;
  /// Size variations of FAB logic constraint bounds.
  final FABType type;
  /// Override standard theme background visual fill.
  final Color? backgroundColor;
  /// Override standard theme icon / text visual fill.
  final Color? foregroundColor;

  const FloatingActionButtonKit({
    super.key,
    required this.onPressed,
    required this.icon,
    this.label,
    this.type = FABType.standard,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (type == FABType.extended) {
      assert(label != null, 'Extended FAB must have a label');
      return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: icon,
        label: Text(label!),
        backgroundColor: backgroundColor ?? context.colorScheme.primary,
        foregroundColor: foregroundColor ?? context.colorScheme.onPrimary,
      );
    }

    return FloatingActionButton(
      onPressed: onPressed,
      mini: type == FABType.mini,
      backgroundColor: backgroundColor ?? context.colorScheme.primary,
      foregroundColor: foregroundColor ?? context.colorScheme.onPrimary,
      child: icon,
    );
  }
}
