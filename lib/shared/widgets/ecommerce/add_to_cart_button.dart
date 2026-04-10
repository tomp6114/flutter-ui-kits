import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A conversion-optimized button providing "Add to Cart" mappings with animated states natively.
class AddToCartButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String label;

  const AddToCartButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.label = 'Add to Cart',
  });

  const AddToCartButton.square({
    super.key,
    required double size,
    this.onPressed,
    this.isLoading = false,
    this.label = 'Add to Cart',
  });

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool _isSuccess = false;

  void _handlePress() {
    if (widget.onPressed == null || widget.isLoading || _isSuccess) return;
    
    widget.onPressed!();
    
    // Simulate brief success state
    setState(() => _isSuccess = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isSuccess = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 48,
      child: ElevatedButton(
        onPressed: _handlePress,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isSuccess ? AppColors.success : context.colorScheme.primary,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.radiusMd),
          elevation: 0,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (widget.isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      );
    }
    
    if (_isSuccess) {
      return const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline, size: 20),
          SizedBox(width: 8),
          Text('Added!', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.add_shopping_cart_rounded, size: 20),
        const SizedBox(width: 8),
        Text(widget.label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
