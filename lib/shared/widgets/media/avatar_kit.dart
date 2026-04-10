import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum AvatarShape { circle, square }

/// A premium avatar kit providing image support, initials fallback, and status indicators.
class AvatarKit extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double size;
  final AvatarShape shape;
  final bool isOnline;
  final Color? statusColor;
  final double borderRadius;

  const AvatarKit({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 48.0,
    this.shape = AvatarShape.circle,
    this.isOnline = false,
    this.statusColor,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: shape == AvatarShape.circle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: shape == AvatarShape.square ? BorderRadius.circular(borderRadius) : null,
            color: context.colorScheme.primaryContainer,
            image: imageUrl != null
                ? DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: imageUrl == null
              ? Center(
                  child: Text(
                    initials?.toUpperCase() ?? '',
                    style: TextStyle(
                      color: context.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: size * 0.4,
                    ),
                  ),
                )
              : null,
        ),
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * 0.28,
              height: size * 0.28,
              decoration: BoxDecoration(
                color: statusColor ?? AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: context.colorScheme.surface, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
