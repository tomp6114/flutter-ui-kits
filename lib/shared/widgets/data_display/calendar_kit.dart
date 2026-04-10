import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// A grid-based month-view calendar providing date selection and visualization natively.
class CalendarKit extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime>? onDateSelected;
  final List<DateTime> highlightedDates;

  const CalendarKit({
    super.key,
    required this.initialDate,
    this.onDateSelected,
    this.highlightedDates = const [],
  });

  @override
  State<CalendarKit> createState() => _CalendarKitState();
}

class _CalendarKitState extends State<CalendarKit> {
  late DateTime _currentMonth;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
    _selectedDate = widget.initialDate;
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth(_currentMonth.year, _currentMonth.month);
    final firstWeekday = DateTime(_currentMonth.year, _currentMonth.month).weekday;
    final totalCells = daysInMonth + (firstWeekday - 1);

    return Column(
      children: [
        _buildHeader(),
        const SizedBox(height: AppSpacing.md),
        _buildWeekdayLabels(),
        const SizedBox(height: AppSpacing.sm),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
          itemCount: totalCells,
          itemBuilder: (context, index) {
            if (index < firstWeekday - 1) {
              return const SizedBox.shrink();
            }

            final day = index - (firstWeekday - 1) + 1;
            final date = DateTime(_currentMonth.year, _currentMonth.month, day);
            final isSelected = _selectedDate != null &&
                _selectedDate!.year == date.year &&
                _selectedDate!.month == date.month &&
                _selectedDate!.day == date.day;
            final isHighlighted = widget.highlightedDates.any((d) =>
                d.year == date.year && d.month == date.month && d.day == date.day);
            final isToday = DateTime.now().year == date.year &&
                DateTime.now().month == date.month &&
                DateTime.now().day == date.day;

            return GestureDetector(
              onTap: () {
                setState(() => _selectedDate = date);
                widget.onDateSelected?.call(date);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.colorScheme.primary
                      : (isHighlighted ? context.colorScheme.primary.withValues(alpha: 0.1) : null),
                  shape: BoxShape.circle,
                  border: isToday && !isSelected
                      ? Border.all(color: context.colorScheme.primary)
                      : null,
                ),
                child: Center(
                  child: Text(
                    day.toString(),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? context.colorScheme.onPrimary
                          : (isHighlighted ? context.colorScheme.primary : null),
                      fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final monthName = _getMonthName(_currentMonth.month);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$monthName ${_currentMonth.year}',
          style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(onPressed: _previousMonth, icon: const Icon(Icons.chevron_left)),
            IconButton(onPressed: _nextMonth, icon: const Icon(Icons.chevron_right)),
          ],
        ),
      ],
    );
  }

  Widget _buildWeekdayLabels() {
    final labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: labels.map((l) {
        return Expanded(
          child: Center(
            child: Text(
              l,
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  String _getMonthName(int month) {
    const names = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return names[month - 1];
  }
}
