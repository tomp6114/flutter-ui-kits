import 'package:flutter/material.dart';

/// Rating input combining drag selection and half star supports utilizing standard icons accurately.
class RatingInput extends StatefulWidget {
  final double initialRating;
  final int maxRating;
  final ValueChanged<double>? onRatingChanged;
  final bool allowHalfStars;
  final double iconSize;

  const RatingInput({
    super.key,
    this.initialRating = 0.0,
    this.maxRating = 5,
    this.onRatingChanged,
    this.allowHalfStars = true,
    this.iconSize = 32.0,
  });

  @override
  State<RatingInput> createState() => _RatingInputState();
}

class _RatingInputState extends State<RatingInput> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  void _handleUpdate(Offset localPosition) {
    if (widget.onRatingChanged == null) return;
    
    // Width of one icon
    final double stepWidth = widget.iconSize;
    // Calculate raw rating
    double exactRating = localPosition.dx / stepWidth;
    
    if (exactRating < 0) exactRating = 0;
    if (exactRating > widget.maxRating) exactRating = widget.maxRating.toDouble();

    double finalRating;
    if (widget.allowHalfStars) {
      final double fraction = exactRating - exactRating.truncate();
      if (fraction < 0.25) {
        finalRating = exactRating.truncateToDouble();
      } else if (fraction < 0.75) {
        finalRating = exactRating.truncate() + 0.5;
      } else {
        finalRating = exactRating.truncate() + 1.0;
      }
    } else {
      finalRating = exactRating.roundToDouble();
    }

    if (finalRating != _currentRating) {
      setState(() {
        _currentRating = finalRating;
      });
      widget.onRatingChanged!(finalRating);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _handleUpdate(details.localPosition);
      },
      onTapDown: (details) {
        _handleUpdate(details.localPosition);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.maxRating, (index) {
          final isFull = _currentRating >= index + 1;
          final isHalf = widget.allowHalfStars && _currentRating > index && _currentRating < index + 1;

          IconData iconData;
          if (isFull) {
            iconData = Icons.star;
          } else if (isHalf) {
            iconData = Icons.star_half;
          } else {
            iconData = Icons.star_border;
          }

          return Icon(
            iconData,
            size: widget.iconSize,
            color: (isFull || isHalf) ? Colors.amber : Colors.grey.withValues(alpha: 0.5),
          );
        }),
      ),
    );
  }
}
