import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/media/avatar_kit.dart';

/// A stacked overlapping avatar collective mapping to user groups natively seamlessly.
class AvatarGroup extends StatelessWidget {
  final List<String> imageUrls;
  final double avatarSize;
  final double overlap;
  final int maxVisible;

  const AvatarGroup({
    super.key,
    required this.imageUrls,
    this.avatarSize = 40.0,
    this.overlap = 12.0,
    this.maxVisible = 5,
  });

  @override
  Widget build(BuildContext context) {
    final visibleCount = imageUrls.length > maxVisible ? maxVisible : imageUrls.length;
    final overflowCount = imageUrls.length - visibleCount;

    return SizedBox(
      height: avatarSize,
      width: (visibleCount * (avatarSize - overlap)) + overlap + (overflowCount > 0 ? avatarSize : 0),
      child: Stack(
        children: [
          ...List.generate(visibleCount, (index) {
            return Positioned(
              left: index * (avatarSize - overlap),
              child: AvatarKit(
                imageUrl: imageUrls[index],
                size: avatarSize,
              ),
            );
          }),
          if (overflowCount > 0)
            Positioned(
              left: visibleCount * (avatarSize - overlap),
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  color: context.colorScheme.secondaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(color: context.colorScheme.surface, width: 2),
                ),
                child: Center(
                  child: Text(
                    '+$overflowCount',
                    style: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
