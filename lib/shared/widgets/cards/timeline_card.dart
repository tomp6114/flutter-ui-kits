import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/cards/basic_card.dart';

enum TimelineLineType { solid, dashed }

/// Predefined layout mapping a vertical timeline node safely natively.
class TimelineCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool isFirst;
  final bool isLast;
  final bool isCompleted;
  final TimelineLineType lineType;

  const TimelineCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isFirst = false,
    this.isLast = false,
    this.isCompleted = true,
    this.lineType = TimelineLineType.solid,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(
                    child: _buildConnector(context),
                  )
                else
                  const SizedBox(height: 16), // initial offset
                  
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? context.colorScheme.primary : context.colorScheme.surface,
                    border: Border.all(
                      color: isCompleted ? context.colorScheme.primary : context.theme.dividerColor,
                      width: 2,
                    ),
                  ),
                ),
                
                if (!isLast)
                  Expanded(
                    child: _buildConnector(context),
                  )
                else
                  const SizedBox(height: 16), // final offset
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: BasicCard(
                hasBorder: true,
                elevation: CardElevation.none,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title, style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        Text(time, style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.onSurface.withValues(alpha: 0.5))),
                      ],
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(subtitle, style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface.withValues(alpha: 0.7))),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildConnector(BuildContext context) {
    final color = isCompleted ? context.colorScheme.primary : context.theme.dividerColor;
    
    if (lineType == TimelineLineType.solid) {
      return Container(width: 2, color: color);
    }
    
    // Simple custom painter for dashed line natively without packages.
    return CustomPaint(
      size: const Size(2, double.infinity),
      painter: _DashedLinePainter(color: color),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;

  _DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width
      ..style = PaintingStyle.stroke;

    const dashHeight = 4.0;
    const dashSpace = 4.0;
    double startY = 0.0;

    while (startY < size.height) {
      canvas.drawLine(Offset(size.width / 2, startY), Offset(size.width / 2, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
