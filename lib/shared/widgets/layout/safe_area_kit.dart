import 'package:flutter/material.dart';

/// A padded safe area wrapper providing optional background color fill mappings natively.
class SafeAreaKit extends StatelessWidget {
  final Widget child;
  final Color? color;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  const SafeAreaKit({
    super.key,
    required this.child,
    this.color,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
  });

  @override
  Widget build(BuildContext context) {
    if (color != null) {
      return Container(
        color: color,
        child: SafeArea(
          top: top,
          bottom: bottom,
          left: left,
          right: right,
          child: child,
        ),
      );
    }
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: child,
    );
  }
}
