import 'package:flutter/material.dart';

/// Breakpoints logic handling mobile, tablet, and desktop thresholds.
class Responsive extends StatelessWidget {
  /// Defines threshold values.
  static const double mobileThreshold = 600;
  static const double tabletThreshold = 1000;

  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  /// True if current screen is mobile.
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileThreshold;

  /// True if current screen is tablet.
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileThreshold &&
      MediaQuery.of(context).size.width < tabletThreshold;

  /// True if current screen is desktop.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletThreshold;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= tabletThreshold) {
          return desktop;
        } else if (constraints.maxWidth >= mobileThreshold && tablet != null) {
          return tablet!;
        } else {
          return mobile;
        }
      },
    );
  }
}
