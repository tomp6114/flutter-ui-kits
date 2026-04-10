import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

class DrawerItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

/// Slide-in drawer bounding mapping header, navigation elements cleanly mapped vertically.
class SideDrawerKit extends StatelessWidget {
  final String headerTitle;
  final String headerSubtitle;
  final String? headerAvatarUrl;
  final List<DrawerItem> items;
  final Widget? footer;

  const SideDrawerKit({
    super.key,
    required this.headerTitle,
    this.headerSubtitle = '',
    this.headerAvatarUrl,
    required this.items,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.colorScheme.surface,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
            ),
            accountName: Text(headerTitle, style: context.textTheme.titleMedium?.copyWith(color: context.colorScheme.onPrimary)),
            accountEmail: headerSubtitle.isNotEmpty 
                ? Text(headerSubtitle, style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onPrimary.withValues(alpha: 0.8)))
                : null,
            currentAccountPicture: CircleAvatar(
              backgroundColor: context.colorScheme.onPrimary,
              backgroundImage: headerAvatarUrl != null ? NetworkImage(headerAvatarUrl!) : null,
              child: headerAvatarUrl == null ? Icon(Icons.person, size: 40, color: context.colorScheme.primary) : null,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: Icon(item.icon, color: context.colorScheme.onSurface.withValues(alpha: 0.7)),
                  title: Text(item.title, style: context.textTheme.bodyLarge),
                  onTap: item.onTap,
                  hoverColor: context.colorScheme.primary.withValues(alpha: 0.05),
                );
              },
            ),
          ),
          if (footer != null) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: footer!,
            ),
          ],
        ],
      ),
    );
  }
}
