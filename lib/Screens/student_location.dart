// ignore_for_file: unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, annotate_overrides, avoid_print, prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:it_schedule/model/constants.dart';
import 'user_screen.dart';

import 'calendar_new.dart';
import 'manager_pin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:it_schedule/model/database.dart";

class StudentLocation extends StatefulWidget {
  // String location;
  //StudentLocation(this.location);
  _StudentLocationState createState() => _StudentLocationState();
}

class _StudentLocationState extends State<StudentLocation> {
  bool? edinburg = false;
  bool? brownsville = false;
  bool? riobank = false;
  String location = "";
  final user = FirebaseAuth.instance.currentUser!;

  void toggled() {
    print('button clicked');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Select your location",
                style: TextStyle(fontSize: 40, color: largeText2),
                key: Key('main')),
            SizedBox(
              height: 40,
            ),
            Container(
                child: Column(
              children: [
                CheckboxListTile(
                    key: Key('edinburg-btn'),
                    checkColor: isHoveringColor,
                    title:
                        Text('Edinburg', style: TextStyle(color: smallText2)),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: edinburg,
                    onChanged: (bool? value) {
                      setState(() {
                        edinburg = value;
                        brownsville = false;
                        riobank = false;
                        location = 'edinburg';
                      });
                    }),
                SizedBox(
                  height: 40,
                ),
                CheckboxListTile(
                    key: Key('brownsville-btn'),
                    checkColor: isHoveringColor,
                    title: Text('Brownsville',
                        style: TextStyle(color: smallText2)),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: brownsville,
                    onChanged: (bool? value2) {
                      setState(() {
                        brownsville = value2;
                        edinburg = false;
                        riobank = false;
                        location = 'brownsville';
                      });
                    }),
                SizedBox(
                  height: 40,
                ),
                CheckboxListTile(
                    key: Key('riobank-btn'),
                    checkColor: isHoveringColor,
                    title:
                        Text('Rio Bank', style: TextStyle(color: smallText2)),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: riobank,
                    onChanged: (bool? value) {
                      setState(() {
                        riobank = value;
                        edinburg = false;
                        brownsville = false;
                        location = 'riobank';
                      });
                    }),
              ],
            )),
            ElevatedButton(
                key: Key('continueDeviceButton'),
                onPressed: // brownsville || edinburg || riobank ?
                    () {
                  ClassHelper.saveLocation(user, location);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalendarScreen()));
                }

                //  Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => ClassHoursScreen()));
                // }

                //: null,
                ,
                style: ElevatedButton.styleFrom(
                  primary: brownsville! || edinburg! || riobank!
                      ? backgroundColor
                      : Colors.grey,
                ),
                child: Text('Continue'))
          ],
        )));
  }
}
