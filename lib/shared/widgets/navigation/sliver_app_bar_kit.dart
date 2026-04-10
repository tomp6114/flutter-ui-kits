import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum SliverAppBarVariant { pinned, floating, snap }

/// Pinned + floating + snap variants scaling natively wrapping parallax backgrounds safely.
class SliverAppBarKit extends StatelessWidget {
  final String expandedTitle;
  final String? collapsedTitle;
  final Widget? background;
  final List<Widget>? actions;
  final SliverAppBarVariant variant;
  final double expandedHeight;
  final Widget? leading;

  const SliverAppBarKit({
    super.key,
    required this.expandedTitle,
    this.collapsedTitle,
    this.background,
    this.actions,
    this.variant = SliverAppBarVariant.pinned,
    this.expandedHeight = 200.0,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: variant == SliverAppBarVariant.pinned || variant == SliverAppBarVariant.snap,
      floating: variant == SliverAppBarVariant.floating || variant == SliverAppBarVariant.snap,
      snap: variant == SliverAppBarVariant.snap,
      leading: leading,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          expandedTitle,
          style: context.textTheme.titleLarge?.copyWith(
            color: background != null ? Colors.white : context.colorScheme.onSurface, // assuming dark background if image is passed generally, this would be highly customized per app
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        background: background != null 
          ? Stack(
              fit: StackFit.expand,
              children: [
                background!,
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : null,
      ),
    );
  }
}
