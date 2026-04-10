import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/shared/widgets/media/image_kit.dart';

/// A semantic placeholder for video content providing play overlays and duration badges natively.
class VideoThumbnail extends StatelessWidget {
  final String imageUrl;
  final String? duration;
  final VoidCallback? onTap;

  const VideoThumbnail({
    super.key,
    required this.imageUrl,
    this.duration,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImageKit(
            imageUrl: imageUrl,
            borderRadius: 12,
            width: double.infinity,
            height: 200,
          ),
          // Play Button Overlay
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 48,
            ),
          ),
          // Duration Badge
          if (duration != null)
            Positioned(
              right: AppSpacing.sm,
              bottom: AppSpacing.sm,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  duration!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
