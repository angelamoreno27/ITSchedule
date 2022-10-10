// ignore_for_file: file_names

import 'package:it_schedule/Screens/class_schedule_admin.dart';
import 'package:flutter/material.dart';
import 'student_info.dart';
import 'package:it_schedule/Screens/class_schedule_admin.dart';

class StudentDetailPage extends StatelessWidget {
  final int index;

  StudentDetailPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details Page'),
      ),
      body: _studentDetail(context),
    );
  }
}

ListView _studentDetail(BuildContext context) {
  return ListView.builder(
      itemCount: student_Info.length,
      itemBuilder: (_, index) {
        return InkWell(
            child: Container(
          width: 200,
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //color: Colors.blue[300],
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 2)
              ]),

              
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Student Name : ${student_Info[index].name}'),
              const SizedBox(height: 10),
              Text('Job Title : ${student_Info[index].job}'),
              const SizedBox(height: 10),
              Text('Position: ${student_Info[index].position}'),
              const SizedBox(height: 10),
            ],
          ),
        ),
       onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ClassSchedule()));
          },

       
        );
      });
}
