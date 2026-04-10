import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/cards/basic_card.dart';

/// Predefined layout for metric value, trend indicator, and a mock sparkline.
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final double trend; // Positive for up, negative for down
  final String trendPrefix;
  final List<double> sparklineData; // Mock data for simple path drawing
  final IconData? icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.trend = 0.0,
    this.trendPrefix = '',
    this.sparklineData = const [],
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPositive = trend >= 0;
    final Color trendColor = isPositive ? AppColors.success : AppColors.errorLight;

    return BasicCard(
      hasBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface.withValues(alpha: 0.6))),
              if (icon != null) Icon(icon, size: 20, color: context.colorScheme.primary),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(
                    isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 16,
                    color: trendColor,
                  ),
                  const SizedBox(width: AppSpacing.xxs),
                  Text(
                    '$trendPrefix${trend.abs().toStringAsFixed(1)}%',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: trendColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (sparklineData.isNotEmpty)
                SizedBox(
                  width: 60,
                  height: 30,
                  child: CustomPaint(
                    painter: _SparklinePainter(data: sparklineData, color: trendColor),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color color;

  _SparklinePainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    
    final double maxVal = data.reduce((curr, next) => curr > next ? curr : next);
    final double minVal = data.reduce((curr, next) => curr < next ? curr : next);
    final double range = maxVal - minVal == 0 ? 1 : maxVal - minVal;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final double stepX = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      final double normalizedY = 1 - ((data[i] - minVal) / range);
      final double x = i * stepX;
      final double y = normalizedY * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.data != data || oldDelegate.color != color;
  }
}
