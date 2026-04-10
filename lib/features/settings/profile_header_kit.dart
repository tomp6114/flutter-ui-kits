import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_typography.dart';
import 'package:flutter_ui_kits/shared/widgets/media/avatar_kit.dart';

/// A premium profile header pattern providing banner-avatar overlap layouts natively.
class ProfileHeaderKit extends StatelessWidget {
  final String name;
  final String email;
  final String? profileImageUrl;
  final String? bannerImageUrl;
  final VoidCallback? onEdit;

  const ProfileHeaderKit({
    super.key,
    required this.name,
    required this.email,
    this.profileImageUrl,
    this.bannerImageUrl,
    this.onEdit,
  });

  String get _initials {
    if (name.isEmpty) return '';
    final parts = name.split(' ');
    if (parts.length > 1) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                image: bannerImageUrl != null
                    ? DecorationImage(image: NetworkImage(bannerImageUrl!), fit: BoxFit.cover)
                    : null,
              ),
              child: bannerImageUrl == null
                  ? Center(child: Icon(Icons.image_outlined, size: 48, color: Theme.of(context).primaryColor.withValues(alpha: 0.3)))
                  : null,
            ),
            Positioned(
              bottom: -50,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: AvatarKit(
                  imageUrl: profileImageUrl,
                  initials: _initials,
                  size: 100,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),
        Text(
          name,
          style: AppTypography.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          email,
          style: AppTypography.textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (onEdit != null)
          OutlinedButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: const Text('Edit Profile'),
          ),
      ],
    );
  }
}
