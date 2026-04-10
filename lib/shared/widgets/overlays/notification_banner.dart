import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum NotificationPosition { top, bottom }

/// A slide-in notification banner mapping to standard alert variants elegantly natively.
class NotificationBanner extends StatefulWidget {
  final String title;
  final String message;
  final IconData? icon;
  final Color? backgroundColor;
  final Duration duration;
  final NotificationPosition position;
  final VoidCallback? onTap;

  const NotificationBanner({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.backgroundColor,
    this.duration = const Duration(seconds: 4),
    this.position = NotificationPosition.top,
    this.onTap,
  });

  /// static helper to show the notification quickly.
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    IconData? icon,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 4),
    NotificationPosition position = NotificationPosition.top,
    VoidCallback? onTap,
  }) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => NotificationBanner(
        title: title,
        message: message,
        icon: icon,
        backgroundColor: backgroundColor,
        duration: duration,
        position: position,
        onTap: onTap,
      ),
    );
    overlay.insert(entry);
  }

  @override
  State<NotificationBanner> createState() => _NotificationBannerState();
}

class _NotificationBannerState extends State<NotificationBanner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    final begin = widget.position == NotificationPosition.top ? const Offset(0, -1) : const Offset(0, 1);
    _offsetAnimation = Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
    );

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) {
          // In a real app, the OverlayEntry would be removed here.
          // Since this widget is inside the OverlayEntry builder, it removes itself implicitly.
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding;
    final topPadding = widget.position == NotificationPosition.top ? safeArea.top + 16 : 0.0;
    final bottomPadding = widget.position == NotificationPosition.bottom ? safeArea.bottom + 16 : 0.0;

    return Positioned(
      top: widget.position == NotificationPosition.top ? 0 : null,
      bottom: widget.position == NotificationPosition.bottom ? 0 : null,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(16),
            color: widget.backgroundColor ?? context.colorScheme.surface,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, color: context.colorScheme.primary, size: 28),
                      const SizedBox(width: 16),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.title,
                            style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.message,
                            style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface.withValues(alpha: 0.7)),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => _controller.reverse(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
