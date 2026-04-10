import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// Predefined slide up sheet configurations bounding handle tracking and scrollable bodies securely.
class BottomSheetKit {
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool isScrollControlled = true,
    bool showHandle = true,
    EdgeInsetsGeometry? padding,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent, // rely on internal container securely for custom margins
      builder: (context) {
        return _BottomSheetContent(
          showHandle: showHandle,
          padding: padding,
          child: child,
        );
      },
    );
  }
}

class _BottomSheetContent extends StatelessWidget {
  final Widget child;
  final bool showHandle;
  final EdgeInsetsGeometry? padding;

  const _BottomSheetContent({
    required this.child,
    this.showHandle = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // Add safe area inset for bottom to prevent clipping on modern devices
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      margin: const EdgeInsets.only(top: kToolbarHeight), // prevent completely covering if scroll controlled goes max
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showHandle)
            Container(
              margin: const EdgeInsets.only(top: 12.0, bottom: 8.0),
              height: 4.0,
              width: 40.0,
              decoration: BoxDecoration(
                color: context.theme.dividerColor,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          Flexible(
            child: SingleChildScrollView(
              padding: padding ?? EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, bottomPadding + bottomInset + AppSpacing.md),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
