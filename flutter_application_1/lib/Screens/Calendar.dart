import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_application_1/Models/course.dart';

String hourValue = '8';
String minuteValue = '30';
List<bool> daysChecked = [false, false, false, false, false];

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class TimeDropDownButton extends StatefulWidget {
  String format;
  String inputValue;
  TimeDropDownButton(this.format, this.inputValue);

  @override
  _TimeDropDownButtonState createState() => _TimeDropDownButtonState();
}

class _TimeDropDownButtonState extends State<TimeDropDownButton> {
  List<String> hours = List<String>.generate(12, (i) => '${i + 1}');
  List<String> minutes = List<String>.generate(12, (i) => '${i * 5}');

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: ((context, setState) {
      return DropdownButton<String>(
        iconSize: 0,
        value: widget.inputValue,
        onChanged: (String? value) {
          setState(() {
            widget.inputValue = value!;
            if (widget.format == "hours") {
              hourValue = widget.inputValue;
            } else {
              minuteValue = widget.inputValue;
            }
          });
        },
        items: (widget.format == "hours" ? hours : minutes)
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              widget.format == "hours"
                  ? value
                  : ('0' + value).substring(value.length + 1 - 2),
              style: const TextStyle(fontSize: 25),
            ),
          );
        }).toList(),
      );
    }));
  }
}

class WeekdayCheckbox extends StatefulWidget {
  int inputDay;
  WeekdayCheckbox(this.inputDay);

  @override
  _WeekdayCheckboxState createState() => _WeekdayCheckboxState();
}

class _WeekdayCheckboxState extends State<WeekdayCheckbox> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: ((context, setState) {
      return Checkbox(
          value: daysChecked[widget.inputDay],
          onChanged: (bool? value) {
            setState(() {
              daysChecked[widget.inputDay] = value!;
            });
          });
    }));
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime chosenDay = DateTime.now();
  DateTime highlightedDay = DateTime.now();
  CalendarFormat formatOfCalendar = CalendarFormat.week;

  TextEditingController courseNameController = TextEditingController();

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
        onDayLongPressed: (selectedDay, focusedDay) {
          setState(() {
            chosenDay = selectedDay;
            highlightedDay = focusedDay;
          });
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
                                  const Text("Add Course Name Below"),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        hintText: 'Enter Course # Here'),
                                    controller: courseNameController,
                                  ),
                                  const Text("\nEnter Time Below"),
                                  Container(
                                      height: 40,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            TimeDropDownButton(
                                                "hours", hourValue),
                                            const Text(
                                              ':',
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            TimeDropDownButton(
                                                "minutes", minuteValue),
                                          ])),
                                  const Text("\nWhat other days is it on?"),
                                  Container(
                                    height: 40,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          const Spacer(
                                            flex: 1,
                                          ),
                                          if (chosenDay.weekday !=
                                              DateTime.monday) ...[
                                            const Text("M"),
                                            const Spacer(
                                              flex: 1,
                                            ),
                                          ],
                                          if (chosenDay.weekday !=
                                              DateTime.tuesday) ...[
                                            const Text("T"),
                                            const Spacer(
                                              flex: 1,
                                            ),
                                          ],
                                          if (chosenDay.weekday !=
                                              DateTime.wednesday) ...[
                                            const Text("W"),
                                            const Spacer(
                                              flex: 1,
                                            ),
                                          ],
                                          if (chosenDay.weekday !=
                                              DateTime.thursday) ...[
                                            const Text("Th"),
                                            const Spacer(
                                              flex: 1,
                                            ),
                                          ],
                                          if (chosenDay.weekday !=
                                              DateTime.friday) ...[
                                            const Text("F"),
                                            const Spacer(
                                              flex: 1,
                                            ),
                                          ],
                                        ]),
                                  ),
                                  Container(
                                      height: 40,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            if (chosenDay.weekday !=
                                                DateTime.monday)
                                              WeekdayCheckbox(0),
                                            if (chosenDay.weekday !=
                                                DateTime.tuesday)
                                              WeekdayCheckbox(1),
                                            if (chosenDay.weekday !=
                                                DateTime.wednesday)
                                              WeekdayCheckbox(2),
                                            if (chosenDay.weekday !=
                                                DateTime.thursday)
                                              WeekdayCheckbox(3),
                                            if (chosenDay.weekday !=
                                                DateTime.friday)
                                              WeekdayCheckbox(4),
                                          ]))
                                ]))),
                    actions: [
                      TextButton(
                        child: const Text("Back"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text("Add"),
                        onPressed: () {
                          String time = hourValue +
                              ':' +
                              ('0' + minuteValue)
                                  .substring(minuteValue.length + 1 - 2);
                          if (courseNameController.text.isEmpty) {
                          } else {
                            if (currentDaySchedule[chosenDay] == null) {
                              currentDaySchedule[chosenDay] = [
                                Course(courseNameController.text, time)
                              ];
                            } else {
                              currentDaySchedule[chosenDay]?.add(
                                  Course(courseNameController.text, time));
                            }

                            DateTime day = chosenDay;
                            for (int x = 0; x < 5; x++) {
                              if (DateTime.monday ==
                                  chosenDay
                                      .subtract(Duration(days: x))
                                      .weekday) {
                                day = chosenDay.subtract(Duration(days: x));
                                break;
                              }
                            }

                            if (chosenDay.weekday != DateTime.monday &&
                                daysChecked[0]) {
                              if (currentDaySchedule[day] == null) {
                                currentDaySchedule[day] = [
                                  Course(courseNameController.text, time)
                                ];
                              } else {
                                currentDaySchedule[day]?.add(
                                    Course(courseNameController.text, time));
                              }
                            }

                            day = day.add(const Duration(days: 1));

                            if (chosenDay.weekday != DateTime.tuesday &&
                                daysChecked[1]) {
                              if (currentDaySchedule[day] == null) {
                                currentDaySchedule[day] = [
                                  Course(courseNameController.text, time)
                                ];
                              } else {
                                currentDaySchedule[day]?.add(
                                    Course(courseNameController.text, time));
                              }
                            }

                            day = day.add(const Duration(days: 1));

                            if (chosenDay.weekday != DateTime.wednesday &&
                                daysChecked[2]) {
                              if (currentDaySchedule[day] == null) {
                                currentDaySchedule[day] = [
                                  Course(courseNameController.text, time)
                                ];
                              } else {
                                currentDaySchedule[day]?.add(
                                    Course(courseNameController.text, time));
                              }
                            }

                            day = day.add(const Duration(days: 1));

                            if (chosenDay.weekday != DateTime.thursday &&
                                daysChecked[3]) {
                              if (currentDaySchedule[day] == null) {
                                currentDaySchedule[day] = [
                                  Course(courseNameController.text, time)
                                ];
                              } else {
                                currentDaySchedule[day]?.add(
                                    Course(courseNameController.text, time));
                              }
                            }

                            day = day.add(const Duration(days: 1));

                            if (chosenDay.weekday != DateTime.friday &&
                                daysChecked[4]) {
                              if (currentDaySchedule[day] == null) {
                                currentDaySchedule[day] = [
                                  Course(courseNameController.text, time)
                                ];
                              } else {
                                currentDaySchedule[day]?.add(
                                    Course(courseNameController.text, time));
                              }
                            }

                            Navigator.pop(context);
                            courseNameController.clear();
                            daysChecked = [false, false, false, false, false];
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ));
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
        calendarStyle: const CalendarStyle(
          isTodayHighlighted: true,
        ),
        headerStyle: const HeaderStyle(
          titleCentered: true,
          // formatButtonVisible: false,
        ),
      ),
      ...(currentDaySchedule[chosenDay] ?? []).map((Course course) => ListTile(
            leading: SizedBox(
              height: 40,
              width: 40,
              child: IconButton(
                icon: const Icon(
                  Icons.highlight_remove,
                  color: Colors.red,
                  size: 25,
                ),
                onPressed: () {
                  currentDaySchedule[chosenDay]?.removeWhere((deletedCourse) =>
                      deletedCourse.courseName == course.courseName &&
                      deletedCourse.courseTime == course.courseTime);
                  setState(() {});
                },
              ),
            ),
            title: Text(
              course.courseName,
              style: TextStyle(fontSize: 20),
            ),
            trailing: Text(
              course.courseTime,
              style: TextStyle(fontSize: 20),
            ),
          ))
    ]);
  }
}
