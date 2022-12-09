
// ignore_for_file: unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_unnecessary_containers, prefer_const_constructors, duplicate_ignore, avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'user_screen.dart';
import 'student_location.dart';

class EmailScreen extends StatefulWidget {
  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  String email = '';
  String id = '';
  bool input = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: Color.fromARGB(255, 75, 74, 74),
        body: Container(
            child: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ignore: prefer_const_constructors
            Text("Please enter your UTRGV email",
                // ignore: prefer_const_constructors
                style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 255, 119, 0),
                    fontFamily: 'arial')),
            TextField(
              key: Key('value'),
              onChanged: (String value) => {
                setState(() {
                  if (value.isEmpty) {
                    input = false;
                  } else if (value.contains('@utrgv.edu')) {
                    input = true;
                  }
                }),
              },
              decoration: InputDecoration(
                  labelStyle: TextStyle(
                fontSize: 26,
                fontFamily: 'arial',
                color: Color.fromARGB(255, 255, 119, 0),
              )),
            ),
            ElevatedButton(
                key: Key('continueButton'),
                onPressed: input
                    ? () {
                        print('button being pressed');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentLocation()));
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  primary:
                      input ? Color.fromARGB(255, 255, 119, 0) : Colors.grey,
                ),
                child: Text('Continue'))
          ]),
    )));
  }
}
