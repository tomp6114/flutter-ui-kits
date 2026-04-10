import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum OrderStatus { placed, processed, shipped, outForDelivery, delivered }

/// A native order providing placed confirmed shipped delivered tracker mappings natively.
class OrderStatusStepper extends StatelessWidget {
  final OrderStatus currentStatus;
  final DateTime? orderDate;

  const OrderStatusStepper({
    super.key,
    required this.currentStatus,
    this.orderDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStep(
          context,
          'Order Placed',
          'We have received your order.',
          OrderStatus.placed,
          isFirst: true,
        ),
        _buildStep(
          context,
          'Processed',
          'Your order is being prepared.',
          OrderStatus.processed,
        ),
        _buildStep(
          context,
          'Shipped',
          'The package is on its way.',
          OrderStatus.shipped,
        ),
        _buildStep(
          context,
          'Out for Delivery',
          'Your package will arrive today.',
          OrderStatus.outForDelivery,
        ),
        _buildStep(
          context,
          'Delivered',
          'Package has been dropped off.',
          OrderStatus.delivered,
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildStep(
    BuildContext context,
    String title,
    String subtitle,
    OrderStatus stepStatus, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    final bool isCompleted = currentStatus.index >= stepStatus.index;
    final bool isCurrent = currentStatus == stepStatus;
    final Color color = isCompleted ? AppColors.success : context.colorScheme.onSurface.withValues(alpha: 0.1);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent ? Colors.white : color,
                  border: isCurrent ? Border.all(color: color, width: 6) : null,
                ),
                child: isCompleted && !isCurrent
                    ? const Icon(Icons.check, size: 12, color: Colors.white)
                    : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: color,
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                      color: isCompleted ? context.colorScheme.onSurface : context.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
