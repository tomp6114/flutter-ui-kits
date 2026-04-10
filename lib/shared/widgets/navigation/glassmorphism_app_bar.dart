import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';

/// A premium glassmorphism app bar providing sticky frosted header effects natively.
class GlassmorphismAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title of the app bar.
  final Widget? title;
  /// Optional actions to display on the right.
  final List<Widget>? actions;
  /// Optional leading widget.
  final Widget? leading;
  /// The background blur intensity.
  final double blur;
  /// The base color of the bar.
  final Color? color;
  /// The height of the bar.
  final double height;

  const GlassmorphismAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.blur = 15.0,
    this.color,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final panelColor = color ?? (Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white);
    
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: panelColor.withValues(alpha: 0.2),
            border: Border(
              bottom: BorderSide(
                color: panelColor.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: title,
            leading: leading,
            actions: actions != null ? [...actions!, const SizedBox(width: AppSpacing.md)] : null,
            centerTitle: true,
          ),
        ),
      ),
    );
  }
}
