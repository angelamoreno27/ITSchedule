// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
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

StreamBuilder _studentDetail(BuildContext context) {
  final CollectionReference _students = FirebaseFirestore.instance.collection('users');
  return StreamBuilder(
    stream: _students.snapshots(),
    builder: (context, snapshot) {
    if(snapshot.hasData) {
      List<int> studentIndices = [];
      for(int i = 0; i < snapshot.data!.docs.length; i++)
        // if(snapshot.data!.docs[i]['email'][0] == 't')
          studentIndices.add(i);
      return ListView.builder(
        itemCount: studentIndices.length,
        itemBuilder: (context, index) {
          final DocumentSnapshot docSnapshot = snapshot.data!.docs[studentIndices[index]];
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
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Student Name : ${docSnapshot['name']}'),
                    const SizedBox(height: 10),
                    Text('Job Title : ${docSnapshot['email']}'),
                    const SizedBox(height: 10),
                    Text('Job Title : ${docSnapshot['role']}'),
                    const SizedBox(height: 10),
                    Text('Position: currently unavailable'),
                    const SizedBox(height: 10),
                    Text('ID : ${docSnapshot.id}'),
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
        }
      );
      }
      else
        return Text("Please wait...");
  });
}
