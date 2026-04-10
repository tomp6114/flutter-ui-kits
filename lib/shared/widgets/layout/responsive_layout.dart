import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/responsive.dart';

/// A comprehensive responsive layout switcher providing specific mappings for 
/// mobile, tablet, and desktop natively.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}
