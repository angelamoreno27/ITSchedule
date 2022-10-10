import "timeslots.dart";
import 'package:flutter/material.dart';

class ClassSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Class Scheldule Page'),
        ),
        body: _classSchedule(context));
  }
}

Widget _classSchedule(BuildContext context) {
  return InkWell(
    child: Container(
      width: 200,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.blue.withOpacity(0.1),
      child: Column(children: const [Text("Class Schedule")]),
    ),
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TimeSlots()));
    },
  );
}
