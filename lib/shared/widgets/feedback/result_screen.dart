import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/primary_button.dart';

enum ResultScreenType { success, error, warning, info }

/// A full-screen or compact result screen mapping success/error states elegantly natively.
class ResultScreen extends StatefulWidget {
  final ResultScreenType type;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final bool isFullScreen;

  const ResultScreen({
    super.key,
    required this.type,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.isFullScreen = true,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.easeOut)),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  (IconData, Color) get _iconAndColor {
    switch (widget.type) {
      case ResultScreenType.success:
        return (Icons.check_circle_outline_rounded, Colors.green);
      case ResultScreenType.error:
        return (Icons.error_outline_rounded, context.colorScheme.error);
      case ResultScreenType.warning:
        return (Icons.warning_amber_rounded, Colors.orange);
      case ResultScreenType.info:
        return (Icons.info_outline_rounded, context.colorScheme.primary);
    }
  }

  @override
  Widget build(BuildContext context) {
    final (icon, color) = _iconAndColor;

    final content = Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: widget.isFullScreen ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 56, color: color),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    widget.description,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (widget.actionLabel != null && widget.onAction != null) ...[
                    const SizedBox(height: AppSpacing.xxl),
                    PrimaryButton(
                      label: widget.actionLabel!,
                      onPressed: widget.onAction!,
                    ),
                  ],
                  if (widget.secondaryActionLabel != null && widget.onSecondaryAction != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    TextButton(
                      onPressed: widget.onSecondaryAction,
                      child: Text(widget.secondaryActionLabel!),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return widget.isFullScreen ? Scaffold(body: content) : content;
  }
}
