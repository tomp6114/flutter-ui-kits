import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/responsive.dart';
import 'package:flutter_ui_kits/shared/widgets/navigation/bottom_nav_kit.dart';
import 'package:flutter_ui_kits/shared/widgets/navigation/mini_rail.dart';

/// A destination for [AdaptiveScaffold] navigation mappings.
class NavDestination {
  final IconData icon;
  final String label;

  const NavDestination({required this.icon, required this.label});
}

/// A high-level scaffold that automatically adapts navigation UI between Rail and BottomNav natively.
class AdaptiveScaffold extends StatelessWidget {
  final List<NavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelectedIndexChanged;
  final Widget body;
  final Widget? appBarTitle;
  final List<Widget>? appBarActions;

  const AdaptiveScaffold({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelectedIndexChanged,
    required this.body,
    this.appBarTitle,
    this.appBarActions,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    final navItems = destinations.map((d) => BottomNavItem(
      icon: d.icon,
      label: d.label,
    )).toList();

    // Desktop/Tablet use Side Rail
    if (isDesktop || isTablet) {
      return Scaffold(
        appBar: AppBar(
          title: appBarTitle,
          actions: appBarActions,
          // Hide drawer burger if using rail
          automaticallyImplyLeading: false, 
        ),
        body: Row(
          children: [
            MiniRail(
              selectedIndex: selectedIndex,
              onItemSelected: onSelectedIndexChanged,
              items: navItems,
            ),
            const VerticalDivider(width: 1, thickness: 1),
            Expanded(child: body),
          ],
        ),
      );
    }

    // Mobile uses Bottom Nav
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        actions: appBarActions,
      ),
      body: body,
      bottomNavigationBar: BottomNavKit(
        items: navItems,
        selectedIndex: selectedIndex,
        onItemSelected: onSelectedIndexChanged,
      ),
    );
  }
}
