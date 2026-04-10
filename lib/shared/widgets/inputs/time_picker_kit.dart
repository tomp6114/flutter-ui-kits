import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum TimePickerVariant { dial, input }

/// Time picker wrapping native dial or input styles.
class TimePickerKit extends StatefulWidget {
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay> onTimeSelected;
  final TimePickerVariant variant;
  final String label;

  const TimePickerKit({
    super.key,
    this.initialTime,
    required this.onTimeSelected,
    this.variant = TimePickerVariant.dial,
    this.label = 'Select Time',
  });

  @override
  State<TimePickerKit> createState() => _TimePickerKitState();
}

class _TimePickerKitState extends State<TimePickerKit> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  void _showPicker() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      initialEntryMode: widget.variant == TimePickerVariant.dial 
          ? TimePickerEntryMode.dial 
          : TimePickerEntryMode.input,
      builder: (context, child) {
        return Theme(
          data: context.theme.copyWith(
            colorScheme: context.colorScheme.copyWith(
              primary: context.colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
      widget.onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showPicker,
      borderRadius: BorderRadius.circular(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.access_time),
        ),
        child: Text(
          _selectedTime == null 
              ? 'No time selected' 
              : _selectedTime!.format(context),
          style: context.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
