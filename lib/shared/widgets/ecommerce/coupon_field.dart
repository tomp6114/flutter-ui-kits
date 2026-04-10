import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A coupon input providing apply button, applied badge, and savings shown mappings natively.
class CouponField extends StatefulWidget {
  final Function(String code) onApply;
  final String? appliedCoupon;
  final double? savings;
  final VoidCallback? onRemove;

  const CouponField({
    super.key,
    required this.onApply,
    this.appliedCoupon,
    this.savings,
    this.onRemove,
  });

  @override
  State<CouponField> createState() => _CouponFieldState();
}

class _CouponFieldState extends State<CouponField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.appliedCoupon != null) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.1),
          borderRadius: AppRadius.radiusMd,
          border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.confirmation_num_outlined, color: Colors.green, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Coupon ${widget.appliedCoupon} Applied',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  if (widget.savings != null)
                    Text(
                      'Saved \$${widget.savings!.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 12, color: Colors.green[700]),
                    ),
                ],
              ),
            ),
            IconButton(
              onPressed: widget.onRemove,
              icon: const Icon(Icons.close, size: 18, color: Colors.green),
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Enter coupon code',
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: AppRadius.radiusMd,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () => widget.onApply(_controller.text),
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: const RoundedRectangleBorder(borderRadius: AppRadius.radiusMd),
          ),
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
