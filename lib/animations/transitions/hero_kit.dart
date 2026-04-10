import 'package:flutter/material.dart';

/// A set of heroes providing easy shared-element transition wrappers mappings natively.
class HeroKit extends StatelessWidget {
  final String tag;
  final Widget child;
  final Widget Function(BuildContext, Animation<double>, HeroFlightDirection, BuildContext, BuildContext)? flightShuttleBuilder;

  const HeroKit({
    super.key,
    required this.tag,
    required this.child,
    this.flightShuttleBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      flightShuttleBuilder: flightShuttleBuilder ?? _defaultFlightShuttleBuilder,
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }

  Widget _defaultFlightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: 1.0, 
          child: child,
        );
      },
      child: flightDirection == HeroFlightDirection.push
          ? toHeroContext.widget
          : fromHeroContext.widget,
    );
  }
}
