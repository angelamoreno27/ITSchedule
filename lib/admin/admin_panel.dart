// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'job_locations.dart';
import 'student_info.dart';
import 'studentDetails.dart';

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: _adminPanel(context),
    );
  }
}

ListView _adminPanel(BuildContext context) {
  return ListView.builder(
    itemCount: 3,
    itemBuilder: (_, index) {
      return Card(
        elevation: 10,
        child: ListTile(
          title: Text(location[index].name),
          leading: Icon(Icons.location_city),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentDetailPage(index)));
          },
        ),
      );
    },
  );
}
