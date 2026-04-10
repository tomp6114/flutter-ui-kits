import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// Collapsed header + animated body reveal natively.
class ExpandableCard extends StatefulWidget {
  final Widget header;
  final Widget body;
  final bool initiallyExpanded;
  final EdgeInsetsGeometry headerPadding;
  final EdgeInsetsGeometry bodyPadding;
  final Color? backgroundColor;

  const ExpandableCard({
    super.key,
    required this.header,
    required this.body,
    this.initiallyExpanded = false,
    this.headerPadding = const EdgeInsets.all(AppSpacing.md),
    this.bodyPadding = const EdgeInsets.all(AppSpacing.md),
    this.backgroundColor,
  });

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(_controller);
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeInOut));

    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? context.colorScheme.surface,
        borderRadius: AppRadius.radiusMd,
        border: Border.all(color: context.colorScheme.outlineVariant ?? AppColors.dividerLight),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: _handleTap,
            borderRadius: AppRadius.radiusMd,
            child: Padding(
              padding: widget.headerPadding,
              child: Row(
                children: [
                  Expanded(child: widget.header),
                  RotationTransition(
                    turns: _iconTurns,
                    child: const Icon(Icons.expand_more),
                  ),
                ],
              ),
            ),
          ),
          ClipRect(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Align(
                  alignment: Alignment.topCenter,
                  heightFactor: _heightFactor.value,
                  child: child,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: context.colorScheme.outlineVariant ?? AppColors.dividerLight,
                    ),
                  ),
                ),
                padding: widget.bodyPadding,
                child: widget.body,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
