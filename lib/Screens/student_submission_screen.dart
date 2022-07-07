import 'package:flutter/material.dart';
import 'package:it_schedule/Screens/class_hours_screen.dart';
import 'package:it_schedule/Screens/student_location.dart';
import 'user_screen.dart';
import 'student_location.dart';

class StudentSubmissionScreen extends StatefulWidget {
  @override
  _StudentSubmissionScreenState createState() =>
      _StudentSubmissionScreenState();
}

class _StudentSubmissionScreenState extends State<StudentSubmissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ClassHoursScreen()));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.orange,
          ),
          alignment: Alignment.topLeft,
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Submitted successfully!',
              style: TextStyle(
                fontFamily: 'arial',
                fontSize: 28,
                color: Colors.orange,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                key: Key('done-btn'),
                onPressed: () {
                  print('done button tapped on recommendation screen');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserScreen()));
                },
                style: ElevatedButton.styleFrom(primary: Colors.orange),
                child: Text('Done'))
          ],
        ),
      ),
    );
  }
}
