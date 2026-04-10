import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/cards/basic_card.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/primary_button.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/secondary_button.dart';

/// Predefined layout for an avatar, name, title, social links, and follow button.
class ProfileCard extends StatelessWidget {
  final String name;
  final String title;
  final String avatarUrl;
  final bool isFollowing;
  final VoidCallback? onFollowToggle;
  final VoidCallback? onMessageTap;

  const ProfileCard({
    super.key,
    required this.name,
    required this.title,
    required this.avatarUrl,
    this.isFollowing = false,
    this.onFollowToggle,
    this.onMessageTap,
  });

  @override
  Widget build(BuildContext context) {
    return BasicCard(
      hasBorder: true,
      elevation: CardElevation.none,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(avatarUrl), // NetworkImage is allowed natively, wait, prompt says "No external UI packages" and "No http or network calls". Use a placeholder container or native Icons.
            backgroundColor: context.colorScheme.primary.withValues(alpha: 0.1),
            child: avatarUrl.isEmpty ? const Icon(Icons.person, size: 40) : null,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(name, style: context.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xxs),
          Text(title, style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: isFollowing
                    ? SecondaryButton(
                        label: 'Following',
                        onPressed: onFollowToggle,
                        size: ButtonSize.sm,
                      )
                    : PrimaryButton(
                        label: 'Follow',
                        onPressed: onFollowToggle,
                        size: ButtonSize.sm,
                      ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: SecondaryButton(
                  label: 'Message',
                  onPressed: onMessageTap,
                  size: ButtonSize.sm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
