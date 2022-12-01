import "timeslots.dart";
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';


class ClassSchedule extends StatelessWidget {
  List<String>weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
  DocumentSnapshot docSnapshot;
  ClassSchedule(this.docSnapshot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Schedule Page'),
      ),
      body: InkWell(
        child: Container(
          width: 400,
          height: 400,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.blue.withOpacity(0.1),
          child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(int i = 0; i < 5; i++) ...[
                  Text(weekdays[i]),
                  if(docSnapshot['schedule'][i.toString()] != null)
                  for(int j = 0; j < docSnapshot['schedule'][i.toString()].length; j+=2)...[
                    if(docSnapshot['schedule'][i.toString()][j+1] != "Possible Worktime" && docSnapshot['schedule'][i.toString()][j+1] != "Added Worktime" && docSnapshot['schedule'][i.toString()][j] != "1" && docSnapshot['schedule'][i.toString()][j] != "0")
                      Row(
                        children: [
                          Spacer(flex: 1),                
                          Text("${docSnapshot['schedule'][i.toString()][j]}  ${docSnapshot['schedule'][i.toString()][j+1]}"),
                          Spacer(flex: 1),
                        ],
                      )
                  ]
                ],
              ]
            ),
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TimeSlotsScreen(docSnapshot)));
        },
      )
    );
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
