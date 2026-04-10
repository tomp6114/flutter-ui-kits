import 'package:flutter/material.dart';

/// A text widget with an inline linear gradient fill natively using canvas masking.
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;

  const GradientText(
    this.text, {
    super.key,
    this.style,
    required this.colors,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
        begin: begin,
        end: end,
      ).createShader(bounds),
      child: Text(
        text,
        style: style ?? const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      ),
    );
  }
}
