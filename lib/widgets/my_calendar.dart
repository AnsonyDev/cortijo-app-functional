import 'package:cortijo_app/core/models/booking.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;
import 'package:table_calendar/table_calendar.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({
    this.initDate,
    this.startDate,
    this.endDate,
    required this.focusedDay,
    this.isRangeDate = true,
    Key? key,
  }) : super(key: key);

  final Function(DateTime?)? startDate;
  final Function(DateTime?)? endDate;
  final Function(DateTime?)? focusedDay;
  final DateTime? initDate;
  final bool isRangeDate;

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  Booking? booking;

  DateTime? _start;
  DateTime? _end;

  @override
  void initState() {
    booking = LocalDataRepository().booking;
    if (widget.initDate != null) {
      _selectedDay = widget.initDate;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TableCalendar(
        focusedDay: widget.initDate ?? _focusedDay,
        firstDay: booking?.checkIn ?? DateTime.now(),
        lastDay:
            booking?.checkOut ?? DateTime.now().add(const Duration(days: 365)),
        headerStyle: HeaderStyle(
          titleTextFormatter: (date, locale) =>
              intl.toBeginningOfSentenceCase(
                  intl.DateFormat.yMMMM(locale).format(date)) ??
              '',
          formatButtonShowsNext: false,
          titleCentered: true,
          // titleTextStyle: AppTextStyle.h3Style,
          formatButtonVisible: false,
        ),
        locale: 'es_ES',
        calendarStyle: CalendarStyle(
          isTodayHighlighted: false,
          selectedDecoration: const BoxDecoration(
            color: AppColors.oliveGreen,
            shape: BoxShape.circle,
          ),
          weekendTextStyle: const TextStyle(color: AppColors.oliveGreen),
          rangeStartDecoration: const BoxDecoration(
            color: AppColors.oliveGreen,
            shape: BoxShape.circle,
          ),
          rangeHighlightColor: AppColors.oliveGreen.withOpacity(0.5),
          rangeEndDecoration: const BoxDecoration(
            color: AppColors.oliveGreen,
            shape: BoxShape.circle,
          ),
        ),
        rangeSelectionMode: widget.isRangeDate
            ? RangeSelectionMode.toggledOn
            : RangeSelectionMode.toggledOff,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        rangeStartDay: _start,
        rangeEndDay: _end,
        onRangeSelected: (start, end, focusedDay) {
          if (widget.isRangeDate) {
            if (end != null) {
              widget.endDate!(end);
            }
            widget.startDate!(start);
          }

          setState(() {
            _start = start;
            _end = end;
            _focusedDay = focusedDay;
          });
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
            widget.focusedDay!(focusedDay);
          });
        },
      ),
    );
  }
}
