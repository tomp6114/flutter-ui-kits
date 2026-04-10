import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/inputs/search_bar_kit.dart';

enum AppBarVariant { standard, large, search }

/// Complete customizable AppBar mapping wrapping searching structurally.
class AppBarKit extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBarVariant variant;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final VoidCallback? onCloseSearch;
  final ValueChanged<String>? onSearch;

  const AppBarKit({
    super.key,
    required this.title,
    this.variant = AppBarVariant.standard,
    this.actions,
    this.onBackTap,
    this.onCloseSearch,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == AppBarVariant.search) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onCloseSearch ?? onBackTap ?? () => Navigator.maybePop(context),
        ),
        title: SearchBarKit(
          onSearch: onSearch,
        ),
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
      );
    }

    if (variant == AppBarVariant.large) {
      return AppBar(
        leading: onBackTap != null ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBackTap) : null,
        title: Text(title),
        centerTitle: false,
        actions: actions,
        // Using SliverAppBar is strictly better for Large app bars mimicking collapsing behavior, 
        // however for a fixed app bar component we utilize the standard styling.
        // The dedicated sliver_app_bar_kit will handle collapsible behavior.
        titleTextStyle: context.textTheme.headlineMedium?.copyWith(color: context.colorScheme.onSurface),
      );
    }

    return AppBar(
      leading: onBackTap != null ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBackTap) : null,
      title: Text(title),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize {
    if (variant == AppBarVariant.large) return const Size.fromHeight(kToolbarHeight * 1.5);
    return const Size.fromHeight(kToolbarHeight);
  }
}
