import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_animations.dart';

/// A set of transitions providing slide, fade, and zoom page route builders mappings natively.
class PageTransitions {
  /// A fade transition builder.
  static Route fadeIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: AppAnimations.normal,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  /// A slide transition builder (Right to Left).
  static Route slideIn(Widget page, {Offset begin = const Offset(1, 0)}) {
    return PageRouteBuilder(
      transitionDuration: AppAnimations.normal,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: begin, end: Offset.zero).animate(
            CurvedAnimation(parent: animation, curve: AppAnimations.standard),
          ),
          child: child,
        );
      },
    );
  }

  /// A zoom/scale transition builder.
  static Route zoomIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: AppAnimations.normal,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: AppAnimations.standard),
          ),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  /// A shared axis transition (simulated native).
  static Route sharedAxis(Widget page) {
    return PageRouteBuilder(
      transitionDuration: AppAnimations.normal,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(30 / 100, 0), end: Offset.zero).animate(
              CurvedAnimation(parent: animation, curve: AppAnimations.standard),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
