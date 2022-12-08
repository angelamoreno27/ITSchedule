// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:it_schedule/model/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'job_locations.dart';
import 'student_info.dart';
import 'studentDetails.dart';
import "package:it_schedule/model/database.dart";
import 'package:firebase_auth/firebase_auth.dart';

class AdminPanel extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    ClassHelper.saveRole(user, "manager");
    return Scaffold(
      body: PickJobLocation(context),
    );
  }
}

ListView _adminPanel(BuildContext context) {
  return ListView.builder(
    itemCount: 3,
    itemBuilder: (_, index) {
      return Card(
        elevation: 100,
        child: SizedBox(
          height: 100,
          width: 100,
          child: Center(
            child: ListTile(
              title: Text(
                location[index].name,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 3,
                    color: largeText2),
              ),
              leading: Icon(
                Icons.location_city,
                color: Colors.black,
                size: 40,
              ),
              trailing: Icon(
                Icons.arrow_forward,
                size: 40,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StudentDetailPage(index, location[index].name)));
              },
            ),
          ),
        ),
      );
    },
  );
}

Widget PickJobLocation(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(100),
    color: backgroundColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Pick A Location",
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              letterSpacing: 3,
              color: largeText2),
        ),
        SizedBox(
          height: 35,
          width: 35,
        ),
        Expanded(child: _adminPanel(context))
      ],
    ),
  );
}
