import 'package:flutter/material.dart';

/// A set of animation providing standard durations and curves mappings natively.
class AppAnimations {
  // Durations
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration extraSlow = Duration(milliseconds: 800);

  // Curves
  static const Curve standard = Curves.easeInOutQuad;
  static const Curve emphasize = Curves.elasticOut;
  static const Curve accelerate = Curves.easeIn;
  static const Curve decelerate = Curves.decelerate;
  static const Curve sharp = Curves.easeInCirc;
}
