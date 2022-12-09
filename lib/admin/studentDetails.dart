// ignore_for_file: file_names, use_key_in_widget_constructors, sort_child_properties_last, prefer_const_constructors, duplicate_ignore, deprecated_member_use, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, avoid_print, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:it_schedule/Screens/class_schedule_admin.dart';
import 'package:flutter/material.dart';
import 'package:it_schedule/model/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:it_schedule/main.dart';
import 'campusSchedule.dart';

class StudentDetailPage extends StatelessWidget {
  final int index;
  final String location;
  final user = FirebaseAuth.instance.currentUser!;

  StudentDetailPage(this.index, this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: matchBGColor,
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CampusScheduleScreen(
                              location: location,
                            )));
              },
              // ignore: prefer_const_constructors
              child: Text("View Campus Schedule",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w800)),
              style: ElevatedButton.styleFrom(
                  primary: matchBGColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: Size(350, 60)),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
              },
              child: const Text("Sign Out",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w800)),
              style: ElevatedButton.styleFrom(
                  primary: matchBGColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: Size(60, 60)),
            ),
          ],
        ),
        body: _studentDetail(context, location));
  }
}

StreamBuilder _studentDetail(BuildContext context, String location) {
  final CollectionReference _students =
      FirebaseFirestore.instance.collection('users');
  print(location);
  return StreamBuilder(
      stream: _students.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<int> studentIndices = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++)
            // ignore: curly_braces_in_flow_control_structures
            if (snapshot.data!.docs[i]['role'] == "student" &&
                // ignore: curly_braces_in_flow_control_structures
                snapshot.data!.docs[i]['location'].length > 0) if (snapshot
                        .data!.docs[i]['location'][0]
                        .toUpperCase() +
                    snapshot.data!.docs[i]['location'].substring(1) ==
                location) 
              studentIndices.add(i);
          return ListView.builder(
              itemCount: studentIndices.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot docSnapshot =
                    snapshot.data!.docs[studentIndices[index]];
                return InkWell(
                  child: Container(
                    width: 100,
                    height: 200,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(spreadRadius: 2, color: boxColor)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Student Name : ${docSnapshot['name']}'),
                        const SizedBox(height: 10),
                        Text('Student Email : ${docSnapshot['email']}'),
                        const SizedBox(height: 10),
                        
                        Text('Position: currently unavailable'),
                        const SizedBox(height: 10),
                      
                        Text('Location : ${docSnapshot['location']}'),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClassSchedule(docSnapshot)));
                  },
                );
              });
        } else
          return Text("Please wait...");
      });
}

Widget ViewCampus(BuildContext context, location) {
  return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CampusScheduleScreen(
                      location: location,
                    )));
      },
      child: Text("View Campus Schedule"));
}
