import 'package:flutter/material.dart';

/// A structural layout providing sidebar and content split mappings with resizable gutter natively.
class TwoColumnLayout extends StatelessWidget {
  final Widget? sidebar;
  final Widget content;
  final double sidebarWidth;
  final bool isSidebarVisible;

  const TwoColumnLayout({
    super.key,
    this.sidebar,
    required this.content,
    this.sidebarWidth = 280.0,
    this.isSidebarVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (sidebar != null && isSidebarVisible) ...[
          SizedBox(
            width: sidebarWidth,
            child: sidebar!,
          ),
          VerticalDivider(width: 1, thickness: 1, color: Theme.of(context).dividerColor),
        ],
        Expanded(
          child: content,
        ),
      ],
    );
  }
}
