import 'package:flutter/material.dart';

/// Defines the color palette for the application, supporting both light and dark modes.
/// Following Material 3 naming conventions and semantic mappings.
class AppColors {
  /// Prevents instantiation.
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryDark = Color(0xFFBB86FC);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryDark = Color(0xFF03DAC6);
  static const Color tertiary = Color(0xFF018786);

  // Background & Surface (Light)
  static const Color backgroundLight = Color(0xFFFDFBFF);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceContainerLight = Color(0xFFF3F2F8);
  static const Color surfaceBrightLight = Color(0xFFFEF7FF);
  
  // Background & Surface (Dark)
  static const Color backgroundDark = Color(0xFF1B1B1F);
  static const Color surfaceDark = Color(0xFF1B1B1F);
  static const Color surfaceContainerDark = Color(0xFF212126);
  static const Color surfaceBrightDark = Color(0xFF3B383E);

  // Semantic Colors (Adaptable)
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorLight = Color(0xFFBA1A1A); 
  static const Color errorDark = Color(0xFFCF6679);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF00C853);
  static const Color warning = Color(0xFFFFAB00);
  static const Color info = Color(0xFF29B6F6);

  // Neutral Colors (Light)
  static const Color onSurfaceLight = Color(0xFF1B1B1F);
  static const Color onSurfaceVariantLight = Color(0xFF44474E);
  static const Color textPrimaryLight = Color(0xDD000000);
  static const Color textSecondaryLight = Color(0x99000000);
  static const Color textDisabledLight = Color(0x61000000);
  static const Color outlineLight = Color(0xFF74777F);
  static const Color outlineVariantLight = Color(0xFFC4C6D0);
  static const Color dividerLight = Color(0xFFE0E0E0);

  // Neutral Colors (Dark)
  static const Color onSurfaceDark = Color(0xFFE3E2E6);
  static const Color onSurfaceVariantDark = Color(0xFFC4C6D0);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xB3FFFFFF);
  static const Color textDisabledDark = Color(0x61FFFFFF);
  static const Color outlineDark = Color(0xFF8E9099);
  static const Color outlineVariantDark = Color(0xFF44474E);
  static const Color dividerDark = Color(0xFF424242);
}
