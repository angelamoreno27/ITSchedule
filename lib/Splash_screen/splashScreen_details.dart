// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'WORK STUDY \n JUST GOT \n EASIER',
            style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 80, height: 0.9),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Making Students Life Easier\n One Day At A Time.',
            style: TextStyle(fontSize: 21, height: 1.7),
          ),
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  final String title;
  const Buttons(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.orange[600], borderRadius: BorderRadius.circular(5)),
    );
  }
}
