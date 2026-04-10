import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';

/// A utility providing named spacing constants as widgets for structural mapping natively.
class SpacerKit extends StatelessWidget {
  final double? size;
  final bool isVertical;

  const SpacerKit({
    super.key,
    this.size,
    this.isVertical = true,
  });

  /// 4.0
  factory SpacerKit.xxs({bool isVertical = true}) => SpacerKit(size: AppSpacing.xxs, isVertical: isVertical);
  /// 8.0
  factory SpacerKit.xs({bool isVertical = true}) => SpacerKit(size: AppSpacing.xs, isVertical: isVertical);
  /// 12.0
  factory SpacerKit.sm({bool isVertical = true}) => SpacerKit(size: AppSpacing.sm, isVertical: isVertical);
  /// 16.0
  factory SpacerKit.md({bool isVertical = true}) => SpacerKit(size: AppSpacing.md, isVertical: isVertical);
  /// 24.0
  factory SpacerKit.lg({bool isVertical = true}) => SpacerKit(size: AppSpacing.lg, isVertical: isVertical);
  /// 32.0
  factory SpacerKit.xl({bool isVertical = true}) => SpacerKit(size: AppSpacing.xl, isVertical: isVertical);
  /// 48.0
  factory SpacerKit.xxl({bool isVertical = true}) => SpacerKit(size: AppSpacing.xxl, isVertical: isVertical);

  @override
  Widget build(BuildContext context) {
    return isVertical ? SizedBox(height: size) : SizedBox(width: size);
  }
}
