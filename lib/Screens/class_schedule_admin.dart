import 'package:it_schedule/model/constants.dart';

import "timeslots.dart";
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

class ClassSchedule extends StatelessWidget {
  List<String> weekdays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];
  DocumentSnapshot docSnapshot;
  ClassSchedule(this.docSnapshot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text("Edit ${docSnapshot['name']} Schedule"),
          backgroundColor: matchBGColor,
        ),
        body: InkWell(
          child: Center(
            child: Container(
              width: 1200,
              height: 800,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: boxColor),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    for (int i = 0; i < 5; i++) ...[
                      Text(
                        weekdays[i],
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.w800),
                      ),
                      if (docSnapshot['schedule'][i.toString()] != null)
                        for (int j = 0;
                            j < docSnapshot['schedule'][i.toString()].length;
                            j += 2) ...[
                          if (docSnapshot['schedule'][i.toString()][j + 1] !=
                                  "Possible Worktime" &&
                              docSnapshot['schedule'][i.toString()][j + 1] !=
                                  "Added Worktime" &&
                              docSnapshot['schedule'][i.toString()][j] != "1" &&
                              docSnapshot['schedule'][i.toString()][j] != "0")
                            Row(
                              children: [
                                Spacer(flex: 2),
                                Text(
                                    "${docSnapshot['schedule'][i.toString()][j]}  ${docSnapshot['schedule'][i.toString()][j + 1]}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800)),
                                Spacer(flex: 2),
                              ],
                            )
                        ],
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ]),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TimeSlotsScreen(docSnapshot)));
          },
        ));
  }
}


// Widget _classSchedule(BuildContext context) {
//   return InkWell(
//     child: Container(
//       width: 200,
//       height: 200,
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       color: Colors.blue.withOpacity(0.1),
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [Text('${widget.docSnapshot}')]),
//     ),
//     onTap: () {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => TimeSlots()));
//     },
//   );
// }
