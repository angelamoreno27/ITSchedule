import 'package:flutter/material.dart';

class TimeSlots extends StatelessWidget {
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
  return Row(
    children: <Widget>[
      const SizedBox(
        width: 100,
        height: 100,
        child: Text(
          "Time Slots",
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.blue.withOpacity(0.1),
        child: const Text(
          "Requested Time Off",
          textAlign: TextAlign.center,
        ),
      )
    ],
  );
}
