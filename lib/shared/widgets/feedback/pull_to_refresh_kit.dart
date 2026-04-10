import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A native pull-to-refresh wrapper integrating custom loading indicators cleanly.
class PullToRefreshKit extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final Color? color;
  final String? semanticsLabel;

  const PullToRefreshKit({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? context.colorScheme.primary,
      backgroundColor: context.colorScheme.surface,
      displacement: 60,
      child: child,
    );
  }
}
