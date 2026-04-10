import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A set of colored label providing tag, closeable, and variant mappings natively.
class TagKit extends StatelessWidget {
  final String label;
  final Color? color;
  final bool isLarge;
  final bool isCloseable;
  final VoidCallback? onClose;
  final IconData? icon;

  const TagKit({
    super.key,
    required this.label,
    this.color,
    this.isLarge = false,
    this.isCloseable = false,
    this.onClose,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = color ?? context.colorScheme.primary;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLarge ? 12 : 8,
        vertical: isLarge ? 6 : 4,
      ),
      decoration: BoxDecoration(
        color: themeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: themeColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: isLarge ? 16 : 14, color: themeColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: themeColor,
              fontWeight: FontWeight.bold,
              fontSize: isLarge ? 13 : 11,
            ),
          ),
          if (isCloseable && onClose != null) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onClose,
              child: Icon(
                Icons.close,
                size: isLarge ? 16 : 14,
                color: themeColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
