import 'package:flutter/material.dart';
import 'package:it_schedule/Screens/student_location.dart';
import 'package:it_schedule/Screens/student_submission_screen.dart';
import 'user_screen.dart';
import 'student_location.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:it_schedule/page/event_editing_page.dart';

class ClassHoursScreen extends StatefulWidget {
  _ClassHoursScreenState createState() => _ClassHoursScreenState();
}

class _ClassHoursScreenState extends State<ClassHoursScreen> {
  bool input = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),

        // actions: buildEditingActions(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color.fromARGB(255, 0, 149, 255),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EventEditingPage())),
      ),
      body: SfCalendar(
        view: CalendarView.month,
      ),
    );
  }
}
