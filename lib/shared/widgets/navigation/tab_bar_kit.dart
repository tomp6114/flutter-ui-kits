import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum TabBarVariant { underline, pill }

/// Complex customizable mapping over native TabBar natively extending decoration possibilities.
class TabBarKit extends StatelessWidget {
  final List<String> tabs;
  final TabController controller;
  final TabBarVariant variant;
  final bool isScrollable;

  const TabBarKit({
    super.key,
    required this.tabs,
    required this.controller,
    this.variant = TabBarVariant.underline,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == TabBarVariant.pill) {
      return Container(
        height: 48,
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: AppRadius.radiusMd,
        ),
        child: TabBar(
          controller: controller,
          isScrollable: isScrollable,
          indicator: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: AppRadius.radiusMd,
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.primary.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: context.colorScheme.onPrimary,
          unselectedLabelColor: context.colorScheme.onSurface,
          tabs: tabs.map((t) => Tab(text: t)).toList(),
          dividerColor: Colors.transparent, // Disable material 3 default bottom divider
        ),
      );
    }

    return TabBar(
      controller: controller,
      isScrollable: isScrollable,
      indicatorWeight: 3.0,
      indicatorColor: context.colorScheme.primary,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: context.colorScheme.primary,
      unselectedLabelColor: context.colorScheme.onSurface.withValues(alpha: 0.6),
      tabs: tabs.map((t) => Tab(text: t)).toList(),
    );
  }
}
