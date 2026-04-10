import 'package:flutter/material.dart';

/// Extensions for BuildContext to simplify theme and sizing lookups.
extension BuildContextThemeX on BuildContext {
  /// Gets the current ThemeData.
  ThemeData get theme => Theme.of(this);

  /// Gets the current TextTheme.
  TextTheme get textTheme => theme.textTheme;

  /// Gets the current ColorScheme.
  ColorScheme get colorScheme => theme.colorScheme;
}

/// Allows checking boolean dimensions tightly.
extension BuildContextSizeX on BuildContext {
  /// Screen width logic.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Screen height logic.
  double get screenHeight => MediaQuery.of(this).size.height;
}
