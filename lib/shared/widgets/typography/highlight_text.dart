import 'package:flutter/material.dart';

/// A text widget providing inline highlight spans for emphasized substrings natively.
class HighlightText extends StatelessWidget {
  final String text;
  final List<String> highlights;
  final TextStyle? baseStyle;
  final TextStyle? highlightStyle;
  final bool caseSensitive;

  const HighlightText({
    super.key,
    required this.text,
    required this.highlights,
    this.baseStyle,
    this.highlightStyle,
    this.caseSensitive = false,
  });

  @override
  Widget build(BuildContext context) {
    if (highlights.isEmpty) {
      return Text(text, style: baseStyle);
    }

    // Build a pattern from all highlight words
    final pattern = highlights
        .map((h) => RegExp.escape(h))
        .join('|');
    final regExp = RegExp(pattern, caseSensitive: caseSensitive);

    final List<TextSpan> spans = [];
    int lastEnd = 0;

    for (final match in regExp.allMatches(text)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start), style: baseStyle));
      }
      spans.add(TextSpan(
        text: match.group(0),
        style: highlightStyle ??
            (baseStyle ?? const TextStyle()).copyWith(
              backgroundColor: Colors.yellow.withValues(alpha: 0.6),
              fontWeight: FontWeight.bold,
            ),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd), style: baseStyle));
    }

    return RichText(text: TextSpan(children: spans));
  }
}
