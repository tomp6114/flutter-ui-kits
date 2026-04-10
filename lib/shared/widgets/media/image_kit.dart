import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/feedback/skeleton_loader.dart';

/// An enhanced image kit providing native skeleton loading and error mapping seamlessly.
class ImageKit extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final Widget? errorWidget;

  const ImageKit({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0.0,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SkeletonLoader(
            width: width ?? double.infinity,
            height: height ?? double.infinity,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? _buildDefaultError(context);
        },
      ),
    );
  }

  Widget _buildDefaultError(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      color: context.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
