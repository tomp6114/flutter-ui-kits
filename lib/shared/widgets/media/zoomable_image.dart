import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/shared/widgets/media/image_kit.dart';

/// A pinch-to-zoom and pan image viewer providing premium double-tap interactions natively.
class ZoomableImage extends StatefulWidget {
  final String imageUrl;
  final double maxScale;
  final double minScale;

  const ZoomableImage({
    super.key,
    required this.imageUrl,
    this.maxScale = 4.0,
    this.minScale = 1.0,
  });

  @override
  State<ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  final TransformationController _transformationController = TransformationController();
  
  void _onDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      // Zoom in to 2.0x on double tap
      const double scale = 2.0;
      _transformationController.value = Matrix4.identity()..scale(scale);
    }
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _onDoubleTap,
      child: InteractiveViewer(
        transformationController: _transformationController,
        minScale: widget.minScale,
        maxScale: widget.maxScale,
        clipBehavior: Clip.none,
        child: ImageKit(
          imageUrl: widget.imageUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
