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

  Map<DateTime, List<Course>> currentDaySchedule = {};

  List<String> hours = List<String>.generate(12, (i) => '${i + 1}');
  List<String> minutes = List<String>.generate(12, (i) => '${i * 5}');
  String hourValue = '8';
  String minuteValue = '30';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TableCalendar(
          firstDay: DateTime.utc(2022, 5, 9),
          lastDay: DateTime.utc(2023, 5, 9),
          focusedDay: highlightedDay,
          calendarFormat: formatOfCalendar,
          enabledDayPredicate: (day) {
            if (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
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
                builder: (context) => 
              AlertDialog(
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
                        Text("\nEnter Time Below"),
                        Container(
                          // color: Colors.amber,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              StatefulBuilder(builder: ((context, setState) {
                                return DropdownButton<String>(
                                  iconSize: 0,
                                  value: hourValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      hourValue = value!;
                                    });
                                  },
                                  items: hours.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: TextStyle(fontSize: 25),),
                                    )
                                  ;}).toList(),
                                );
                              })),
                              const Text(':', style: TextStyle(fontSize: 25),),
                              StatefulBuilder(builder: ((context, setState) {
                                return DropdownButton<String>(
                                  iconSize: 0,
                                  value: minuteValue,
                                  onChanged: (String? value) {
                                    String tempValue = minuteValue;
                                    setState(() {
                                      minuteValue = value!;
                                    });
                                  },
                                  items: minutes.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(('0' + value).substring(value.length + 1 - 2), style: TextStyle(fontSize: 25),),
                                    );
                                  }).toList(),
                                );
                              })),
                            ]
                          )
                        ),
                      ]
                    )
                  )
                ),
                actions: [
                  TextButton(
                    child: const Text("Back"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: const Text("Add"),
                    onPressed: () {
                      if (courseNameController.text.isEmpty) {
                        ;
                      } 
                      else {
                        if (currentDaySchedule[chosenDay] == null) {
                          currentDaySchedule[chosenDay] = [Course(courseNameController.text, hourValue + ':' + ('0' + minuteValue).substring(minuteValue.length + 1 - 2))];
                        } 
                        else {
                            currentDaySchedule[chosenDay]?.add(Course(courseNameController.text, hourValue + ':' + ('0' + minuteValue).substring(minuteValue.length + 1 - 2)));
                        }
                      Navigator.pop(context);
                      courseNameController.clear();
                      setState(() {});
                      }
                    },
                  ),
                ],
              )
            );
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
              leading: const Icon(Icons.panorama_fish_eye),
              title: Text(course.courseName),
              trailing: Text(course.courseTime),
        ))
      ]
    );
  }
}
