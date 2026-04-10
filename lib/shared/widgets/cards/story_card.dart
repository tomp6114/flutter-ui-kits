import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';

/// Predefined layout for a circular avatar bounded by an arc representing progress logically mapping stories natively.
class StoryCard extends StatelessWidget {
  final String imageUrl;
  final String label;
  final double progress; // 0.0 to 1.0 (completion amount for the ring)
  final VoidCallback? onTap;

  const StoryCard({
    super.key,
    required this.imageUrl,
    required this.label,
    this.progress = 1.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomPaint(
            painter: _StoryRingPainter(
              progress: progress,
              unviewedColor: context.colorScheme.primary,
              viewedColor: context.theme.dividerColor,
            ),
            child: Container(
              padding: const EdgeInsets.all(4.0), // gap between ring and image
              child: CircleAvatar(
                radius: 36.0,
                backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                backgroundColor: context.colorScheme.surfaceContainerHighest,
                child: imageUrl.isEmpty ? const Icon(Icons.person, size: 36) : null,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: progress < 1.0 ? FontWeight.bold : FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _StoryRingPainter extends CustomPainter {
  final double progress;
  final Color unviewedColor;
  final Color viewedColor;

  _StoryRingPainter({
    required this.progress,
    required this.unviewedColor,
    required this.viewedColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final backgroundPaint = Paint()
      ..color = viewedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final progressPaint = Paint()
      ..color = unviewedColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    // Draw background ring (viewed portions)
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc (unviewed portions)
    if (progress < 1.0) {
      final sweepAngle = 2 * pi * (1.0 - progress);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2, // start at top
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _StoryRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
           oldDelegate.unviewedColor != unviewedColor ||
           oldDelegate.viewedColor != viewedColor;
  }
}
