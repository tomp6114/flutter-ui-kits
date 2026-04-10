import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// Wrapped custom styled tooltip natively utilizing Tooltip dynamically.
class TooltipKit extends StatelessWidget {
  final Widget child;
  final String message;
  final bool preferBelow;
  final EdgeInsetsGeometry padding;

  const TooltipKit({
    super.key,
    required this.child,
    required this.message,
    this.preferBelow = false,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      preferBelow: preferBelow,
      decoration: BoxDecoration(
        color: context.colorScheme.onSurface.withValues(alpha: 0.9), // Dark tooltip typically
        borderRadius: BorderRadius.circular(6.0),
      ),
      textStyle: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.surface),
      padding: padding,
      margin: const EdgeInsets.all(4.0),
      showDuration: const Duration(milliseconds: 1500),
      waitDuration: const Duration(milliseconds: 500),
      child: child,
    );
  }
}
