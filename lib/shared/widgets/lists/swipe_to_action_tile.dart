import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';

enum SwipeActionType { delete, archive, custom }

class SwipeAction {
  final IconData icon;
  final Color color;
  final String? label;
  final SwipeActionType type;
  final VoidCallback onAction;

  const SwipeAction({
    required this.icon,
    required this.color,
    required this.onAction,
    this.label,
    this.type = SwipeActionType.custom,
  });
}

/// A list tile providing left + right swipe actions with animated backgrounds natively.
class SwipeToActionTile extends StatelessWidget {
  final Widget child;
  final SwipeAction? leftAction;
  final SwipeAction? rightAction;
  final String id;

  const SwipeToActionTile({
    super.key,
    required this.id,
    required this.child,
    this.leftAction,
    this.rightAction,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      direction: _determineDirection(),
      background: _buildBackground(leftAction, Alignment.centerLeft),
      secondaryBackground: _buildBackground(rightAction, Alignment.centerRight),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          leftAction?.onAction();
        } else {
          rightAction?.onAction();
        }
      },
      child: child,
    );
  }

  DismissDirection _determineDirection() {
    if (leftAction != null && rightAction != null) return DismissDirection.horizontal;
    if (leftAction != null) return DismissDirection.startToEnd;
    if (rightAction != null) return DismissDirection.endToStart;
    return DismissDirection.none;
  }

  Widget _buildBackground(SwipeAction? action, Alignment alignment) {
    if (action == null) return const SizedBox.shrink();

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      color: action.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(action.icon, color: Colors.white, size: 28),
          if (action.label != null) ...[
            const SizedBox(height: 4),
            Text(
              action.label!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
