import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalanderScreen extends StatefulWidget {
  const CalanderScreen({super.key});

  @override
  State<CalanderScreen> createState() => _CalanderScreenState();
}

class _CalanderScreenState extends State<CalanderScreen> {
  DateTime? chosenDay;
  DateTime? highlightedDay;
  CalendarFormat calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TableCalendar(
        firstDay: DateTime.utc(2022, 5, 9),
        lastDay: DateTime.utc(2023, 5, 9),
        focusedDay: DateTime.now(),
        calendarFormat: calendarFormat,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        weekendDays: [DateTime.saturday, DateTime.sunday],
        selectedDayPredicate: (day) {
          if (day != DateTime.saturday && day != DateTime.sunday)
            return isSameDay(chosenDay, day);
          return false;
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            chosenDay = selectedDay;
            highlightedDay = focusedDay;
          });
        },
        onFormatChanged: (format) {
          calendarFormat = format;
        },
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
        ),
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
      )
    ]);
  }
}
