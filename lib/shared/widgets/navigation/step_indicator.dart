import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum StepDirection { horizontal, vertical }

class StepItem {
  final String title;
  final String? subtitle;

  const StepItem({required this.title, this.subtitle});
}

/// Multi-state structural map rendering linear steps bounds natively seamlessly.
class StepIndicatorKit extends StatelessWidget {
  final List<StepItem> steps;
  final int currentStep;
  final StepDirection direction;
  final ValueChanged<int>? onStepTapped;

  const StepIndicatorKit({
    super.key,
    required this.steps,
    this.currentStep = 0,
    this.direction = StepDirection.horizontal,
    this.onStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == StepDirection.vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(steps.length, (index) => _buildVerticalStep(context, index)),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length, (index) => _buildHorizontalStep(context, index)),
    );
  }

  Widget _buildVerticalStep(BuildContext context, int index) {
    final bool isLast = index == steps.length - 1;
    final bool isCompleted = index < currentStep;
    final bool isActive = index == currentStep;
    final step = steps[index];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _buildDot(context, isCompleted, isActive, index),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? context.colorScheme.primary : context.theme.dividerColor,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xl),
              child: InkWell(
                onTap: onStepTapped != null ? () => onStepTapped!(index) : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title, 
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                        color: (isCompleted || isActive) ? context.colorScheme.onSurface : context.colorScheme.onSurface.withValues(alpha: 0.5)
                      )
                    ),
                    if (step.subtitle != null) ...[
                      const SizedBox(height: AppSpacing.xxs),
                      Text(step.subtitle!, style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface.withValues(alpha: 0.6))),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalStep(BuildContext context, int index) {
    final bool isLast = index == steps.length - 1;
    final bool isCompleted = index < currentStep;
    final bool isActive = index == currentStep;
    final step = steps[index];

    return Expanded(
      child: InkWell(
         onTap: onStepTapped != null ? () => onStepTapped!(index) : null,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    color: index == 0 ? Colors.transparent : (isCompleted || isActive ? context.colorScheme.primary : context.theme.dividerColor),
                  ),
                ),
                _buildDot(context, isCompleted, isActive, index),
                Expanded(
                  child: Container(
                    height: 2,
                    color: isLast ? Colors.transparent : (isCompleted ? context.colorScheme.primary : context.theme.dividerColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              step.title, 
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: (isCompleted || isActive) ? context.colorScheme.onSurface : context.colorScheme.onSurface.withValues(alpha: 0.5)
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(BuildContext context, bool isCompleted, bool isActive, int index) {
    const size = 28.0;
    
    if (isCompleted) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: context.colorScheme.primary),
        child: Icon(Icons.check, size: 16, color: context.colorScheme.onPrimary),
      );
    }
    
    if (isActive) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle, 
          border: Border.all(color: context.colorScheme.primary, width: 2),
        ),
        child: Center(
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(shape: BoxShape.circle, color: context.colorScheme.primary),
          ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle, 
        border: Border.all(color: context.theme.dividerColor, width: 2),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.onSurface.withValues(alpha: 0.5)),
        ),
      ),
    );
  }
}
