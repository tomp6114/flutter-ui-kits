import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_typography.dart';
import 'package:flutter_ui_kits/shared/widgets/media/avatar_kit.dart';

/// A premium dashboard header providing greeting, avatar, and notification logic natively.
class GreetingHeader extends StatelessWidget {
  final String userName;
  final String? profileImageUrl;
  final bool hasNotifications;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const GreetingHeader({
    super.key,
    required this.userName,
    this.profileImageUrl,
    this.hasNotifications = false,
    this.onNotificationTap,
    this.onProfileTap,
  });

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  String get _initials {
    if (userName.isEmpty) return '';
    final parts = userName.split(' ');
    if (parts.length > 1) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onProfileTap,
            child: AvatarKit(
              imageUrl: profileImageUrl,
              initials: _initials,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _greeting,
                  style: AppTypography.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
                Text(
                  userName,
                  style: AppTypography.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onNotificationTap,
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none_rounded, size: 28),
                if (hasNotifications)
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
