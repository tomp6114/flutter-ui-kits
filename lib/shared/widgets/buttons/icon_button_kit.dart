import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum IconButtonShape { circle, square }

/// Circle + square icon button, with badge support.
class IconButtonKit extends StatelessWidget {
  /// Callback executed when the button is pressed.
  final VoidCallback? onPressed;
  /// If true, visually dims the button and ignores interactions.
  final bool isDisabled;
  /// The icon widget.
  final Widget icon;
  /// Shape constraint for the button.
  final IconButtonShape shape;
  /// Background color fill, defaults to transparent.
  final Color? backgroundColor;
  /// Size of the standard interactable area.
  final double size;
  /// Numeric value for badge display.
  final int? badgeCount;
  /// Displays a prominent error text color dot.
  final bool hasDotBadge;

  const IconButtonKit({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isDisabled = false,
    this.shape = IconButtonShape.circle,
    this.backgroundColor,
    this.size = 48.0,
    this.badgeCount,
    this.hasDotBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool actuallyDisabled = isDisabled || onPressed == null;
    final bgColor = backgroundColor ?? Colors.transparent;

    final Widget buttonArea = Material(
      color: actuallyDisabled ? bgColor.withValues(alpha: 0.5) : bgColor,
      shape: shape == IconButtonShape.circle
          ? const CircleBorder()
          : RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        onTap: actuallyDisabled ? null : onPressed,
        customBorder: shape == IconButtonShape.circle
            ? const CircleBorder()
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Opacity(
              opacity: actuallyDisabled ? 0.5 : 1.0,
              child: icon,
            ),
          ),
        ),
      ),
    );

    if (badgeCount != null || hasDotBadge) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          buttonArea,
          Positioned(
            top: 2,
            right: 2,
            child: _buildBadge(context),
          ),
        ],
      );
    }

    return buttonArea;
  }

  Widget _buildBadge(BuildContext context) {
    if (badgeCount != null && badgeCount! > 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: context.colorScheme.error,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: const BoxConstraints(
          minWidth: 16,
          minHeight: 16,
        ),
        child: Text(
          badgeCount! > 99 ? '99+' : badgeCount.toString(),
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.onError,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      );
    } else if (hasDotBadge) {
      return Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: context.colorScheme.error,
          shape: BoxShape.circle,
          border: Border.all(color: context.colorScheme.surface, width: 2),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
