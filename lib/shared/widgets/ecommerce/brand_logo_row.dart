import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/shared/widgets/media/image_kit.dart';

/// A set of brands providing horizontal scrollable brand logos strip mappings natively.
class BrandLogoRow extends StatelessWidget {
  final List<String> logoUrls;
  final double height;

  const BrandLogoRow({
    super.key,
    required this.logoUrls,
    this.height = 60.0,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: logoUrls.map((url) {
          return Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Opacity(
              opacity: 0.6,
              child: ImageKit(
                imageUrl: url,
                height: height,
                fit: BoxFit.contain,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
