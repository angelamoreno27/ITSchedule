import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:it_schedule/Screens/manager_pin.dart';
import 'package:it_schedule/Screens/student_location.dart';
import 'package:it_schedule/model/database.dart';
import 'package:it_schedule/widget/signup_widget.dart';
import 'jobs_screen.dart';
import 'student_submission_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:it_schedule/widget/login_widget.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool? manager = false;
  bool? student = false;
  String user = "";
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool idk = false;

  void toggled() {
    print('button clicked');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Are you a manager or a student?",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold),
                key: Key('main')),
            Container(
                child: Column(
              children: [
                CheckboxListTile(
                    key: Key('manager-btn'),
                    title:
                        Text('Manager', style: TextStyle(color: Colors.blue)),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: manager,
                    onChanged: (bool? value) {
                      setState(() {
                        manager = value;
                        student = false;
                        user = 'manager';
                      });
                    }),
                CheckboxListTile(
                    key: Key('student-btn'),
                    title:
                        Text('Student', style: TextStyle(color: Colors.blue)),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: student,
                    onChanged: (bool? value2) {
                      setState(() {
                        student = value2;
                        manager = false;
                        user = 'student';
                      });
                    })
              ],
            )),
            ElevatedButton(
                key: Key('continueDeviceButton'),
                onPressed:
                      student! || manager! ?
                    () {
                      if(student!){
                        ClassHelper.saveRole(currentUser, "student");
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentLocation()));
                      }
                      else if( manager!){
                         Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ManagerPIN()));
                      }
                    
                }
                  : null,

                style: ElevatedButton.styleFrom(
                    primary: student! || manager! ?
                        Colors.blue
                    : Colors.grey,
                    ),
                child: Text('Continue')),
          ],
        )));
  }
}
