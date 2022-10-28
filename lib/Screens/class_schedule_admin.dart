import "timeslots.dart";
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';


class ClassSchedule extends StatelessWidget {

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
          width: 200,
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.blue.withOpacity(0.1),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('${json.encode(docSnapshot['schedule'])}')]),
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TimeSlots()));
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
