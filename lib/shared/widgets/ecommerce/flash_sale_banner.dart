import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A flash sale banner providing countdown timer and discount mappings natively.
class FlashSaleBanner extends StatefulWidget {
  final String title;
  final Duration duration;
  final String? imageUrl;
  final VoidCallback? onTap;

  const FlashSaleBanner({
    super.key,
    required this.title,
    required this.duration,
    this.imageUrl,
    this.onTap,
  });

  @override
  State<FlashSaleBanner> createState() => _FlashSaleBannerState();
}

class _FlashSaleBannerState extends State<FlashSaleBanner> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = widget.duration;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining.inSeconds > 0) {
        setState(() => _remaining -= const Duration(seconds: 1));
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: AppRadius.radiusLg,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.deepOrange, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppRadius.radiusLg,
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildTimeBox(_remaining.inHours.toString().padLeft(2, '0')),
                      const Text(' : ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      _buildTimeBox((_remaining.inMinutes % 60).toString().padLeft(2, '0')),
                      const Text(' : ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      _buildTimeBox((_remaining.inSeconds % 60).toString().padLeft(2, '0')),
                    ],
                  ),
                ],
              ),
            ),
            if (widget.imageUrl != null)
              Image.network(widget.imageUrl!, height: 80, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeBox(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        value,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
