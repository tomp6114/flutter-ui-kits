import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A set of subtotal providing item count, discount, delivery, and total mappings natively.
class CartSummary extends StatelessWidget {
  final int itemCount;
  final double subtotal;
  final double deliveryFee;
  final double? discount;
  final VoidCallback? onCheckout;

  const CartSummary({
    super.key,
    required this.itemCount,
    required this.subtotal,
    required this.deliveryFee,
    this.discount,
    this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final double total = subtotal + deliveryFee - (discount ?? 0);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: AppRadius.radiusLg,
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRow(context, 'Subtotal ($itemCount items)', '\$${subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _buildRow(context, 'Delivery Fee', '\$${deliveryFee.toStringAsFixed(2)}'),
          if (discount != null) ...[
            const SizedBox(height: 8),
            _buildRow(
              context,
              'Discount',
              '-\$${discount!.toStringAsFixed(2)}',
              valueColor: Colors.green,
            ),
          ],
          const Divider(height: 32),
          _buildRow(
            context,
            'Total',
            '\$${total.toStringAsFixed(2)}',
            isBold: true,
            size: 18,
          ),
          if (onCheckout != null) ...[
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: const RoundedRectangleBorder(borderRadius: AppRadius.radiusMd),
              ),
              child: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
    double size = 14,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: size,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: size,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: valueColor ?? (isBold ? context.colorScheme.onSurface : context.colorScheme.onSurface.withValues(alpha: 0.7)),
          ),
        ),
      ],
    );
  }
}
