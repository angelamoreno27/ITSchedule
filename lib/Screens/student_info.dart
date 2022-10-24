import 'dart:html';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'user_screen.dart';
import 'class_hours_screen.dart';
import 'calendar_new.dart';

class StudentInfo extends StatefulWidget {
  @override
  _StudentInfoState createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                style: TextStyle(fontSize: 20, fontFamily: 'arial'),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your First Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                style: TextStyle(fontSize: 20, fontFamily: 'arial'),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Last Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(fontSize: 20, fontFamily: 'arial'),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your UTRGV Student ID',
                ),
              ),
            ),
            ElevatedButton(
                key: Key('continueDeviceButton'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalendarScreen()));
                },
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                child: Text('Continue'))
          ],
        ));
  }
}
