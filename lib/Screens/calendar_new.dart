import 'dart:html';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:it_schedule/model/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:it_schedule/model/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:it_schedule/model/database.dart";
import 'package:it_schedule/main.dart';

String startHourValue = '8';
String startMinuteValue = '30';
String finishHourValue = '9';
String finishMinuteValue = '30';
List<bool> daysChecked = [false, false, false, false, false];

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class TimeDropDownButton extends StatefulWidget {
  String format;
  String inputValue;
  String classTime;
  TimeDropDownButton(this.format, this.inputValue, this.classTime);

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
        // iconSize: 0,
        icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
        value: widget.inputValue,
        onChanged: (String? value) {
          setState(() {
            widget.inputValue = value!;
            if (widget.format == "hours") {
              if (widget.classTime == "start") {
                startHourValue = widget.inputValue;
              } else {
                finishHourValue = widget.inputValue;
              }
            } else {
              if (widget.classTime == "start") {
                startMinuteValue = widget.inputValue;
              } else {
                finishMinuteValue = widget.inputValue;
              }
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
  List<int> weekdays = [
    DateTime.monday,
    DateTime.tuesday,
    DateTime.wednesday,
    DateTime.thursday,
    DateTime.friday
  ];
  List<String> dayAbbreviations = ["M", "T", "W", "Th", "F"];
  bool isDaySelected = false;
  String error = "";
  final user = FirebaseAuth.instance.currentUser!;
  Map<String, List<String>> firebaseSchedule = {};

  List<Course> sortSchedule(List<Course> schedule) {
    schedule.sort((a, b) {
      DateTime time1 = DateTime.now(), time2 = time1;
      int hourInput = int.parse(
          a.courseStartTime.substring(0, a.courseStartTime.indexOf(":")));
      int minuteInput = int.parse(
          a.courseStartTime.substring(a.courseStartTime.indexOf(":") + 1));
      hourInput = (hourInput < 6) ? hourInput + 12 : hourInput;

      time1 = time1.add(Duration(hours: hourInput, minutes: minuteInput));

      hourInput = int.parse(
          b.courseStartTime.substring(0, b.courseStartTime.indexOf(":")));
      minuteInput = int.parse(
          b.courseStartTime.substring(b.courseStartTime.indexOf(":") + 1));
      hourInput = (hourInput < 6) ? hourInput + 12 : hourInput;

      time2 = time2.add(Duration(hours: hourInput, minutes: minuteInput));

      if (time1.isAfter(time2)) {
        return 1;
      }
      return 0;
    });
    return schedule;
  }

  int adjustHour(int hour, int minute, bool type) {
    if (hour < 7) {
      hour += 12;
    }
    if (type) {
      if (minute + 30 >= 60) {
        hour += 1;
      }
    } else {
      if (minute - 30 < 0) {
        hour -= 1;
      }
    }
    return hour;
  }

  int adjustMinute(int minute, bool type) {
    if (type) {
      if (minute + 30 >= 60) {
        minute -= 30;
      } else {
        minute += 30;
      }
    } else {
      if (minute - 30 < 0) {
        minute += 30;
      } else {
        minute -= 30;
      }
    }
    return minute;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
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
          isDaySelected = true;
          if (selectedDay == chosenDay && highlightedDay == focusedDay) {
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
                                    const Text(
                                      "Add Course Name Below",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800),
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          hintStyle:
                                              TextStyle(color: Colors.red),
                                          hintText: 'Enter Course # Here'),
                                      controller: courseNameController,
                                      validator: (value) => value!.isEmpty
                                          ? 'Please enter a course name'
                                          : null,
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
                                              TimeDropDownButton("hours",
                                                  startHourValue, "start"),
                                              const Text(
                                                ':',
                                                style: TextStyle(fontSize: 25),
                                              ),
                                              TimeDropDownButton("minutes",
                                                  startMinuteValue, "start"),
                                              const Text(
                                                '-',
                                                style: TextStyle(fontSize: 25),
                                              ),
                                              TimeDropDownButton("hours",
                                                  finishHourValue, "finish"),
                                              const Text(
                                                ':',
                                                style: TextStyle(fontSize: 25),
                                              ),
                                              TimeDropDownButton("minutes",
                                                  finishMinuteValue, "finish"),
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
                                            for (int x = 0; x < 5; x++)
                                              if (chosenDay.weekday !=
                                                  weekdays[x]) ...[
                                                Text(dayAbbreviations[x]),
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
                                              const Spacer(
                                                flex: 1,
                                              ),
                                              for (int x = 0; x < 5; x++)
                                                if (chosenDay.weekday !=
                                                    weekdays[x]) ...[
                                                  WeekdayCheckbox(x),
                                                  const Spacer(
                                                    flex: 1,
                                                  )
                                                ],
                                            ])),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 20),
                                    //   child: Text(error, style: TextStyle(color: Colors.red))
                                    // )
                                  ]))),
                      actions: [
                        TextButton(
                          child: const Text("Back"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Text("Add"),
                          onPressed: () {
                            String startTime = startHourValue +
                                ':' +
                                ('0' + startMinuteValue)
                                    .substring(startMinuteValue.length + 1 - 2);
                            String finishTime = finishHourValue +
                                ':' +
                                ('0' + finishMinuteValue).substring(
                                    finishMinuteValue.length + 1 - 2);
                            Course newCourse = Course(courseNameController.text,
                                startTime, finishTime);
                            bool timeOccupied = false;

                            if (currentDaySchedule[chosenDay] == null ||
                                currentDaySchedule[chosenDay]!.isEmpty) {
                            } else {
                              for (int x =
                                      currentDaySchedule[chosenDay]!.length - 1;
                                  x >= 0;
                                  x--) {
                                if (currentDaySchedule[chosenDay]![x]
                                        .courseName ==
                                    "Possible Worktime") {
                                  continue;
                                }

                                if ((newCourse.courseEnd.hour <=
                                            currentDaySchedule[chosenDay]![x]
                                                .courseEnd
                                                .hour &&
                                        newCourse.courseEnd.hour >=
                                            currentDaySchedule[chosenDay]![x]
                                                .courseStart
                                                .hour)
                                    // || newCourse.courseEnd.hour == currentDaySchedule[chosenDay]![x].courseEnd.hour && newCourse.courseEnd.hour > currentDaySchedule[chosenDay]![x].courseEnd.hour
                                    ||
                                    newCourse.courseStart.hour <=
                                            currentDaySchedule[chosenDay]![x]
                                                .courseEnd
                                                .hour &&
                                        newCourse.courseStart.hour >=
                                            currentDaySchedule[chosenDay]![x]
                                                .courseStart
                                                .hour) {
                                  timeOccupied = true;
                                  break;
                                }
                              }
                            }

                            if (courseNameController.text.isEmpty ||
                                newCourse.courseStart.hour >=
                                    newCourse.courseEnd.hour ||
                                ((newCourse.courseEnd.hour -
                                                newCourse.courseStart.hour)
                                            .abs() ==
                                        1 &&
                                    newCourse.courseEnd.minute -
                                            newCourse.courseStart.minute <
                                        0) ||
                                timeOccupied) {
                              if (newCourse.courseStart.hour >=
                                      newCourse.courseEnd.hour ||
                                  ((newCourse.courseEnd.hour -
                                                  newCourse.courseStart.hour)
                                              .abs() ==
                                          1 &&
                                      newCourse.courseEnd.minute -
                                              newCourse.courseStart.minute <
                                          0)) {
                                error =
                                    "The course could not be added due to an invalid time input";
                                Navigator.pop(context);
                              } else if (timeOccupied) {
                                error =
                                    "The course could not be added due to the time input already being occupied.";
                                Navigator.pop(context);
                              } else {
                                error = "";
                              }
                              setState(() {});
                            } else {
                              if (currentDaySchedule[chosenDay] == null) {
                                currentDaySchedule[chosenDay] = [newCourse];
                              } else {
                                currentDaySchedule[chosenDay]?.removeWhere(
                                    (course) =>
                                        course.courseName ==
                                        "Possible Worktime");
                                currentDaySchedule[chosenDay]?.add(newCourse);
                                error = "";
                                currentDaySchedule[chosenDay] = sortSchedule(
                                    currentDaySchedule[chosenDay]!);
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

                              for (int x = 0; x < 5; ++x) {
                                if (chosenDay.weekday != weekdays[x] &&
                                    daysChecked[x]) {
                                  if (currentDaySchedule[day] == null) {
                                    currentDaySchedule[day] = [newCourse];
                                  } else {
                                    currentDaySchedule[day]?.removeWhere(
                                        (course) =>
                                            course.courseName ==
                                            "Possible Worktime");
                                    currentDaySchedule[day]?.add(newCourse);
                                    error = "";
                                    currentDaySchedule[day] =
                                        sortSchedule(currentDaySchedule[day]!);
                                  }
                                  setState(() {});
                                }
                                day = day.add(const Duration(days: 1));
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
          } else {
            setState(() {
              chosenDay = selectedDay;
              highlightedDay = focusedDay;
            });
          }
        },
        // onDayLongPressed: (selectedDay, focusedDay) {

        // },
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
      Text(error, style: TextStyle(color: Colors.red)),
      //             Text(
      //   user.email!,
      //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      // ),
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
                      deletedCourse.courseStartTime == course.courseStartTime &&
                      deletedCourse.courseEndTime == course.courseEndTime);
                  setState(() {});
                },
              ),
            ),
            title: Text(
              course.courseName,
              style: const TextStyle(fontSize: 20),
            ),
            trailing: Text(
              course.courseStartTime + "-" + course.courseEndTime,
              style: const TextStyle(fontSize: 20),
            ),
          )),
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Spacer(
                flex: 1,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: backgroundColor,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minimumSize: Size(150, 50)),
                  onPressed: isDaySelected
                      ? () {
                          // print(firebaseSchedule);
                          firebaseSchedule = {};
                          TimeOfDay time3, time4;
                          int eventsAmount;
                          var temp;
                          int hourValue, minuteValue;

                          DateTime day = chosenDay;
                          for (int x = 0; x < 5; x++) {
                            if (DateTime.monday ==
                                day.subtract(Duration(days: x)).weekday) {
                              day = day.subtract(Duration(days: x));
                              break;
                            }
                          }

                          for (int x = 0; x < 5; x++) {
                            if (currentDaySchedule[day] == null ||
                                currentDaySchedule[day]!.isEmpty) {
                              currentDaySchedule[day] = [
                                Course("Possible Worktime", "8:00", "5:00")
                              ];
                              error = "";
                              firebaseSchedule[x.toString()] = ["8:00-5:00"];
                              firebaseSchedule[x.toString()]
                                  ?.add("Possible Worktime");
                              firebaseSchedule[x.toString()]
                                  ?.add("Job Not Chosen");
                              firebaseSchedule[x.toString()]?.add("hide");
                              setState(() {});
                              day = day.add(const Duration(days: 1));
                              continue;
                            }

                            eventsAmount = currentDaySchedule[day]!.length;
                            temp = currentDaySchedule[day]?[0].courseStartTime;
                            hourValue =
                                int.parse(temp.substring(0, temp.indexOf(":")));
                            minuteValue = int.parse(
                                temp.substring(temp.indexOf(":") + 1));
                            hourValue =
                                adjustHour(hourValue, minuteValue, false);
                            minuteValue = adjustMinute(minuteValue, false);
                            time4 =
                                TimeOfDay(hour: hourValue, minute: minuteValue);

                            if ((time4.hour >= 9)) {
                              String worktimeStart = "8:00";
                              String worktimeEnd = (time4.hour > 12
                                          ? time4.hour - 12
                                          : time4.hour)
                                      .toString() +
                                  ":" +
                                  ('0' + time4.minute.toString()).substring(
                                      time4.minute.toString().length + 1 - 2);
                              // currentDaySchedule[chosenDay]?.removeWhere((course) => course.courseName == "Possible Worktime");
                              error = "";
                              currentDaySchedule[day]?.add(Course(
                                  "Possible Worktime",
                                  worktimeStart,
                                  worktimeEnd));
                              currentDaySchedule[day] =
                                  sortSchedule(currentDaySchedule[day]!);
                              eventsAmount++;
                            }

                            for (int x = 0; x < eventsAmount - 1;) {
                              temp = currentDaySchedule[day]?[x].courseEndTime;

                              hourValue = int.parse(
                                  temp!.substring(0, temp.indexOf(":")));
                              minuteValue = int.parse(
                                  temp.substring(temp.indexOf(":") + 1));
                              hourValue =
                                  adjustHour(hourValue, minuteValue, true);
                              minuteValue = adjustMinute(minuteValue, true);

                              time3 = TimeOfDay(
                                  hour: hourValue, minute: minuteValue);
                              temp =
                                  currentDaySchedule[day]?[++x].courseStartTime;

                              hourValue = int.parse(
                                  temp!.substring(0, temp.indexOf(":")));
                              minuteValue = int.parse(
                                  temp.substring(temp.indexOf(":") + 1));
                              hourValue =
                                  adjustHour(hourValue, minuteValue, false);
                              minuteValue = adjustMinute(minuteValue, false);

                              time4 = TimeOfDay(
                                  hour: hourValue, minute: minuteValue);

                              if (time3.hour < time4.hour &&
                                  !(((time3.hour - time4.hour).abs() == 1) &&
                                      time3.minute > time4.minute)) {
                                String worktimeStart = (time3.hour > 12
                                            ? time3.hour - 12
                                            : time3.hour)
                                        .toString() +
                                    ":" +
                                    ('0' + time3.minute.toString()).substring(
                                        time3.minute.toString().length + 1 - 2);
                                String worktimeEnd = (time4.hour > 12
                                            ? time4.hour - 12
                                            : time4.hour)
                                        .toString() +
                                    ":" +
                                    ('0' + time4.minute.toString()).substring(
                                        time4.minute.toString().length + 1 - 2);
                                error = "";

                                // currentDaySchedule[day]?.removeWhere((course) => course.courseName == "Possible Worktime");
                                currentDaySchedule[day]?.add(Course(
                                    "Possible Worktime",
                                    worktimeStart,
                                    worktimeEnd));
                                currentDaySchedule[day] =
                                    sortSchedule(currentDaySchedule[day]!);
                                eventsAmount++;
                              }
                            }

                            for (int i = eventsAmount - 1; i >= 0; i--) {
                              temp = currentDaySchedule[day]?[i].courseEndTime;

                              hourValue = int.parse(
                                  temp.substring(0, temp.indexOf(":")));
                              minuteValue = int.parse(
                                  temp.substring(temp.indexOf(":") + 1));
                              hourValue =
                                  adjustHour(hourValue, minuteValue, true);
                              minuteValue = adjustMinute(minuteValue, true);

                              time4 = TimeOfDay(
                                  hour: hourValue, minute: minuteValue);
                              bool singleCourse =
                                  eventsAmount - 1 == i ? true : false;
                              bool clearSchedule = singleCourse
                                  ? true
                                  : (int.parse(currentDaySchedule[day]![i + 1]
                                              .courseStartTime
                                              .substring(
                                                  0,
                                                  currentDaySchedule[day]![
                                                          i + 1]
                                                      .courseStartTime
                                                      .indexOf(":"))) <
                                          17
                                      ? false
                                      : true);

                              if (clearSchedule &&
                                  (time4.hour < 16 ||
                                      (16 == time4.hour &&
                                          time4.minute == 0))) {
                                String worktimeStart = (time4.hour > 12
                                            ? time4.hour - 12
                                            : time4.hour)
                                        .toString() +
                                    ":" +
                                    ('0' + time4.minute.toString()).substring(
                                        time4.minute.toString().length + 1 - 2);
                                String worktimeEnd = "5:00";
                                error = "";
                                currentDaySchedule[day]?.add(Course(
                                    "Possible Worktime",
                                    worktimeStart,
                                    worktimeEnd));
                                currentDaySchedule[day] =
                                    sortSchedule(currentDaySchedule[day]!);
                                eventsAmount++;
                                setState(() {});
                                break;
                              }
                            }
                            for (int y = 0;
                                y < currentDaySchedule[day]!.length;
                                y++) {
                              if (firebaseSchedule[x.toString()] == null)
                                firebaseSchedule[x.toString()] = [
                                  currentDaySchedule[day]![y].courseStartTime +
                                      "-" +
                                      currentDaySchedule[day]![y].courseEndTime
                                ];
                              else
                                firebaseSchedule[x.toString()]?.add(
                                    currentDaySchedule[day]![y]
                                            .courseStartTime +
                                        "-" +
                                        currentDaySchedule[day]![y]
                                            .courseEndTime);
                              firebaseSchedule[x.toString()]
                                  ?.add(currentDaySchedule[day]![y].courseName);
                              if (currentDaySchedule[day]![y].courseName ==
                                  "Possible Worktime") {
                                firebaseSchedule[x.toString()]?.add("0");
                                firebaseSchedule[x.toString()]
                                    ?.add("Job Not Chosen");
                              }
                            }
                            setState(() {});
                            day = day.add(const Duration(days: 1));
                          }
                          ClassHelper.saveSchedule(user, firebaseSchedule);
                        }
                      : null,
                  child: const Text("Generate Week Schedule")),
              const Spacer(
                flex: 1,
              ),
              // FutureBuilder(
              //   future: ClassHelper.getSchedule(user),
              //   builder: (context, snapshot) {

              //   },

              // )
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: backgroundColor,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minimumSize: Size(150, 50)),
                  onPressed: /*firebaseSchedule.length > 0 ?*/ () {
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
                                            FutureBuilder(
                                              // https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html
                                              future: ClassHelper()
                                                  .getSchedule(user),
                                              builder: (context, snapshot) {
                                                List<Widget> shifts;
                                                if (snapshot.hasData) {
                                                  Map<String, dynamic>
                                                      schedule = snapshot.data!;
                                                  List<String> shiftString = [
                                                    "",
                                                    "",
                                                    "",
                                                    "",
                                                    ""
                                                  ];
                                                  for (int dayIndex = 0;
                                                      dayIndex < 5;
                                                      dayIndex++) {
                                                    if (schedule[dayIndex
                                                            .toString()] !=
                                                        null) {
                                                      for (int courseIndex = 0;
                                                          courseIndex <
                                                              schedule[dayIndex
                                                                      .toString()]
                                                                  .length;
                                                          courseIndex += 2) {
                                                        if (schedule[dayIndex
                                                                        .toString()]
                                                                    [
                                                                    courseIndex +
                                                                        1] ==
                                                                "Possible Worktime" ||
                                                            schedule[dayIndex
                                                                        .toString()]
                                                                    [
                                                                    courseIndex +
                                                                        1] ==
                                                                "Added Worktime") {
                                                          shiftString[
                                                              dayIndex] = shiftString[
                                                                  dayIndex] +
                                                              schedule[dayIndex
                                                                      .toString()]
                                                                  [
                                                                  courseIndex] +
                                                              ": " +
                                                              schedule[dayIndex
                                                                      .toString()]
                                                                  [courseIndex +
                                                                      1] +
                                                              " " +
                                                              schedule[dayIndex
                                                                      .toString()]
                                                                  [courseIndex +
                                                                      3] +
                                                              "\n";
                                                        }
                                                      }
                                                    }
                                                    if (shiftString[dayIndex] ==
                                                        "")
                                                      shiftString[dayIndex] =
                                                          "No Worktimes Available\n";
                                                  }
                                                  shifts = <Widget>[
                                                    Text(
                                                      dayAbbreviations[0],
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(shiftString[0]),
                                                    Text(
                                                      dayAbbreviations[1],
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(shiftString[1]),
                                                    Text(
                                                      dayAbbreviations[2],
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(shiftString[2]),
                                                    Text(
                                                      dayAbbreviations[3],
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(shiftString[3]),
                                                    Text(
                                                      dayAbbreviations[4],
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(shiftString[4]),
                                                  ];
                                                } else
                                                  shifts = <Widget>[
                                                    Text("Please Wait...")
                                                  ];
                                                return Column(children: shifts);
                                              },
                                            )
                                          ]))),
                              actions: [
                                TextButton(
                                  child: const Text("Back"),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ));
                  } /* : null*/,
                  child: const Text("View Shifts")
                  // FutureBuilder(
                  //   future: ClassHelper().getSchedule(user),
                  //   builder: (context, snapshot) {
                  //     return Text(json.encode(snapshot.data));
                  //   },
                  // )
                  ),
              const Spacer(
                flex: 1,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: backgroundColor,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minimumSize: Size(150, 50)),
                  onPressed: () async {
                    // setState(() {}),
                    await FirebaseAuth.instance.signOut();

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => CalendarScreen())),
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage()));

                    setState(() {});
                  },
                  child: const Text("Sign Out")),
              const Spacer(
                flex: 1,
              ),
            ]),
      )
    ])));
  }
}
