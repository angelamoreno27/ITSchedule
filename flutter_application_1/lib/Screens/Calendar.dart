import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_application_1/course.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime chosenDay = DateTime.now();
  DateTime highlightedDay = DateTime.now();
  CalendarFormat formatOfCalendar = CalendarFormat.week;

  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseTimeController = TextEditingController();

  Map<DateTime, List<Course>> currentDaySchedule = {};

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TableCalendar(
        firstDay: DateTime.utc(2022, 5, 9),
        lastDay: DateTime.utc(2023, 5, 9),
        focusedDay: highlightedDay,
        calendarFormat: formatOfCalendar,
        enabledDayPredicate: (day) {
          if (day.weekday == DateTime.saturday ||
              day.weekday == DateTime.sunday) {
            return false;
          }
          return true;
        },
        selectedDayPredicate: (day) {
          return isSameDay(chosenDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            chosenDay = selectedDay;
            highlightedDay = focusedDay;
          });
        },
        onDayLongPressed: (selectedDay, focusedDay) => {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Center(
                        heightFactor: 1,
                        child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text("Add Course Name and Time"),
                                  TextFormField(
                                    controller: courseNameController,
                                  ),
                                  TextFormField(
                                    controller: courseTimeController,
                                  ),
                                ]))),
                    actions: [
                      TextButton(
                        child: Text("Back"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: Text("Add"),
                        onPressed: () {
                          if (courseNameController.text.isEmpty ||
                              courseTimeController.text.isEmpty) {
                          } else {
                            if (currentDaySchedule[chosenDay] == null) {
                              currentDaySchedule[chosenDay] = [
                                Course(courseNameController.text,
                                    courseTimeController.text)
                              ];
                            } else {
                              currentDaySchedule[chosenDay]?.add(Course(
                                  courseNameController.text,
                                  courseTimeController.text));
                            }
                            Navigator.pop(context);
                            courseNameController.clear();
                            courseTimeController.clear();
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ))
        },
        onFormatChanged: (format) {
          setState(() {
            formatOfCalendar = format;
          });
        },
        onPageChanged: ((focusedDay) {
          highlightedDay = focusedDay;
        }),
        eventLoader: ((day) {
          return currentDaySchedule[day] ?? [];
        }),
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
        ),
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
      ),
      ...(currentDaySchedule[chosenDay] ?? []).map((Course course) => ListTile(
            leading: Icon(Icons.panorama_fish_eye),
            title: Text(course.courseName),
            trailing: Text(course.courseTime),
          ))
    ]);
  }
}
