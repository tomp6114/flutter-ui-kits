import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum DatePickerVariant { inline, bottomSheet }

/// Standard date picker wrapping inline calendar natively or triggering bottom sheet mode.
class DatePickerKit extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime> onDateSelected;
  final DatePickerVariant variant;
  final String label;

  const DatePickerKit({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.onDateSelected,
    this.variant = DatePickerVariant.bottomSheet,
    this.label = 'Select Date',
  });

  @override
  State<DatePickerKit> createState() => _DatePickerKitState();
}

class _DatePickerKitState extends State<DatePickerKit> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  void _showBottomSheet() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2101),
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

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.variant == DatePickerVariant.inline) {
      return CalendarDatePicker(
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: widget.firstDate ?? DateTime(2000),
        lastDate: widget.lastDate ?? DateTime(2101),
        onDateChanged: (picked) {
          setState(() {
            _selectedDate = picked;
          });
          widget.onDateSelected(picked);
        },
      );
    }

    return InkWell(
      onTap: _showBottomSheet,
      borderRadius: BorderRadius.circular(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(
          _selectedDate == null 
              ? 'No date selected' 
              : '${_selectedDate!.toLocal()}'.split(' ')[0],
          style: context.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
