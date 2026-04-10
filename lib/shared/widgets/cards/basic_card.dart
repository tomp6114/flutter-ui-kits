import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_shadows.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum CardElevation { none, sm, md, lg }

/// Standard base card scaling with elevation offsets and customizable border thresholds.
class BasicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final CardElevation elevation;
  final bool hasBorder;
  final BorderRadius borderRadius;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const BasicCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.elevation = CardElevation.sm,
    this.hasBorder = false,
    this.borderRadius = AppRadius.radiusMd,
    this.backgroundColor,
    this.onTap,
  });

  List<BoxShadow> get _shadows {
    switch (elevation) {
      case CardElevation.none: return AppShadows.none;
      case CardElevation.sm: return AppShadows.sm;
      case CardElevation.md: return AppShadows.md;
      case CardElevation.lg: return AppShadows.lg;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget cardContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.surface,
        borderRadius: borderRadius,
        border: hasBorder
            ? Border.all(color: context.colorScheme.outlineVariant ?? AppColors.dividerLight)
            : null,
        boxShadow: hasBorder && elevation == CardElevation.none ? [] : _shadows,
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }
}
