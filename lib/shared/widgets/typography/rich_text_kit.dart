import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A segment of text for [RichTextKit] with specific styling and interaction patterns.
class TextSegment {
  final String text;
  final TextStyle? style;
  final VoidCallback? onTap;
  final bool isLink;

  const TextSegment(
    this.text, {
    this.style,
    this.onTap,
    this.isLink = false,
  });
}

/// A convenience wrapper for RichText providing structured segments Mapping natively.
class RichTextKit extends StatelessWidget {
  final List<TextSegment> segments;
  final TextStyle? baseStyle;
  final TextAlign textAlign;

  const RichTextKit({
    super.key,
    required this.segments,
    this.baseStyle,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: baseStyle ?? context.textTheme.bodyMedium,
        children: segments.map((segment) {
          return WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: segment.onTap,
              child: Text(
                segment.text,
                style: segment.style ?? (segment.isLink 
                    ? TextStyle(color: context.colorScheme.primary, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)
                    : null),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
