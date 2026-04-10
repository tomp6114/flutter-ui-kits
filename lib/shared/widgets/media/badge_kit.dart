import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum BadgeVariant { dot, label }

/// Deep structural badge mapper wrapping native targets intuitively cleanly parsing offset positions.
class BadgeKit extends StatelessWidget {
  final Widget child;
  final BadgeVariant variant;
  final String label;
  final Color? color;
  final Offset offset;
  final bool isVisible;

  const BadgeKit({
    super.key,
    required this.child,
    this.variant = BadgeVariant.dot,
    this.label = '',
    this.color,
    this.offset = const Offset(4, -4),
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return child;

    final badgeColor = color ?? context.colorScheme.error;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: offset.dy,
          right: offset.dx,
          child: variant == BadgeVariant.dot
              ? _buildDotBadge(badgeColor)
              : _buildLabelBadge(badgeColor, context),
        ),
      ],
    );
  }

  Widget _buildDotBadge(Color badgeColor) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
    );
  }

  Widget _buildLabelBadge(Color badgeColor, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      constraints: const BoxConstraints(
        minWidth: 16,
        minHeight: 16,
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          height: 1, // align tightly
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
