import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// Functional RGB color picker with hex input matching.
class ColorPickerKit extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPickerKit({
    super.key,
    this.initialColor = Colors.blue,
    required this.onColorChanged,
  });

  @override
  State<ColorPickerKit> createState() => _ColorPickerKitState();
}

class _ColorPickerKitState extends State<ColorPickerKit> {
  late double _r;
  late double _g;
  late double _b;
  final TextEditingController _hexController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateFromColor(widget.initialColor);
  }

  void _updateFromColor(Color color) {
    _r = (color.r * 255).round().toDouble();
    _g = (color.g * 255).round().toDouble();
    _b = (color.b * 255).round().toDouble();
    _hexController.text = color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase();
  }

  void _notifyChange() {
    final color = Color.fromARGB(255, _r.toInt(), _g.toInt(), _b.toInt());
    if (_hexController.text.toUpperCase() != color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()) {
      _hexController.text = color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase();
    }
    widget.onColorChanged(color);
  }

  void _handleHexSubmit(String value) {
    if (value.length == 6) {
      try {
        final parsed = Color(int.parse('FF$value', radix: 16));
        setState(() {
          _updateFromColor(parsed);
        });
        widget.onColorChanged(parsed);
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = Color.fromRGBO(_r.toInt(), _g.toInt(), _b.toInt(), 1.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: currentColor,
            shape: BoxShape.circle,
            border: Border.all(color: context.theme.dividerColor),
          ),
        ),
        const SizedBox(height: 16.0),
        _buildSlider('R', _r, Colors.red, (val) => setState(() { _r = val; _notifyChange(); })),
        _buildSlider('G', _g, Colors.green, (val) => setState(() { _g = val; _notifyChange(); })),
        _buildSlider('B', _b, Colors.blue, (val) => setState(() { _b = val; _notifyChange(); })),
        const SizedBox(height: 16.0),
        SizedBox(
          width: 120,
          child: TextField(
            controller: _hexController,
            decoration: const InputDecoration(
              prefixText: '#',
              labelText: 'HEX',
              border: OutlineInputBorder(),
            ),
            maxLength: 6,
            onSubmitted: _handleHexSubmit,
          ),
        ),
      ],
    );
  }

  Widget _buildSlider(String label, double value, Color activeColor, ValueChanged<double> onChanged) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          child: Slider(
            value: value,
            max: 255,
            activeColor: activeColor,
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 32, child: Text(value.toInt().toString())),
      ],
    );
  }
}
