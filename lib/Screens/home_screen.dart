// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:it_schedule/Screens/class_hours_screen.dart';
import 'package:it_schedule/Screens/student_location.dart';
import 'package:it_schedule/Screens/user_screen.dart';
import 'package:it_schedule/admin/admin_panel.dart';
import 'package:it_schedule/model/constants.dart';
import "package:it_schedule/model/database.dart";
import 'package:it_schedule/Screens/calendar_new.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          height: 800,
          width: 1200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: boxColor),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('Currently Signed in as ',
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 3,
                          color: largeText2)),
                  const SizedBox(height: 30),
                  Text(
                    user.email!,
                    style: const TextStyle(
                        fontSize: 30, letterSpacing: 1, color: largeText2),
                  ),
                  const SizedBox(height: 40),
                  // add something
                  ElevatedButton(
                      child: Text('Continue'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w800)),
                      key: Key('continueDeviceButton'),
                      style: ElevatedButton.styleFrom(
                          primary: backgroundColor,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minimumSize: Size(350, 60)),
                      onPressed: //student || manager ?
                          () {
                        Future<String> role =
                            Future(() => ClassHelper().getRole(user));
                        role.then((value) {
                          if (value == "student")
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const CalendarScreen())));
                          else if (value == "manager")
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => AdminPanel())));
                          else
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserScreen()));
                        });
                      }),
                  const SizedBox(
                    width: 20,
                    height: 16,
                  ),
                  Hero(
                    tag: 'signout-btn',
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: backgroundColor,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            minimumSize: Size(350, 60)),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        child: Text('Signout'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w800))),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
