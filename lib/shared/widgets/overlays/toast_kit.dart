import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';

/// Overlay-based toast securely mapping independently from standard scaffold mechanics logically.
class ToastKit {
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
    Color? backgroundColor,
    Color textColor = Colors.white,
    Alignment alignment = Alignment.bottomCenter,
  }) {
    final overlay = Overlay.of(context);
    
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: alignment == Alignment.topCenter ? MediaQuery.of(context).padding.top + 20 : null,
        bottom: alignment == Alignment.bottomCenter ? MediaQuery.of(context).padding.bottom + 50 : null,
        left: 24,
        right: 24,
        child: Align(
          alignment: alignment,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: backgroundColor ?? Colors.black87,
                borderRadius: AppRadius.radiusMd,
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4)),
                ],
              ),
              child: Text(
                message,
                style: TextStyle(color: textColor, fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}
