import 'package:flutter/material.dart';

/// Range slider wrapping native multi-thumb selections with labeled handles internally native to Material.
class RangeSliderKit extends StatefulWidget {
  final double min;
  final double max;
  final int divisions;
  final RangeValues initialValues;
  final ValueChanged<RangeValues> onChanged;

  const RangeSliderKit({
    super.key,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions = 100,
    this.initialValues = const RangeValues(20.0, 80.0),
    required this.onChanged,
  });

  @override
  State<RangeSliderKit> createState() => _RangeSliderKitState();
}

class _RangeSliderKitState extends State<RangeSliderKit> {
  late RangeValues _currentValues;

  @override
  void initState() {
    super.initState();
    _currentValues = widget.initialValues;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RangeSlider(
          values: _currentValues,
          min: widget.min,
          max: widget.max,
          divisions: widget.divisions,
          labels: RangeLabels(
            _currentValues.start.round().toString(),
            _currentValues.end.round().toString(),
          ),
          onChanged: (values) {
            setState(() {
              _currentValues = values;
            });
            widget.onChanged(values);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${widget.min.round()}'),
            Text('${widget.max.round()}'),
          ],
        )
      ],
    );
  }
}
