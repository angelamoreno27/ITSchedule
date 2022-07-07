import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:it_schedule/Screens/class_hours_screen.dart';
import 'package:it_schedule/Screens/student_location.dart';
import 'package:it_schedule/Screens/user_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          leading: BackButton(),
        ),
        body: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Signed in as ', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text(
                  user.email!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    icon: Icon(Icons.arrow_back, size: 32),
                    label: Text('Sign Out', style: TextStyle(fontSize: 24))),
                SizedBox(height: 40),
                ElevatedButton(
                    child: Text('Continue'),
                    key: Key('continueDeviceButton'),
                    onPressed: //student || manager ?
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserScreen()));
                    })
              ],
            )));
  }
}
