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
          backgroundColor: matchBGColor,
          leading: BackButton(),
          elevation: 0,
        ),
        backgroundColor: backgroundColor,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Select your location",
                style: TextStyle(
                    fontSize: 40,
                    color: largeText2,
                    fontWeight: FontWeight.bold),
                key: Key('main')),
            SizedBox(
              height: 40,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 500),
                child: Column(
                  children: [
                    CheckboxListTile(
                        key: Key('edinburg-btn'),
                        checkColor: isHoveringColor,
                        activeColor: boxColor,
                        title: Text('Edinburg',
                            style: TextStyle(color: smallText2)),
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
                        activeColor: boxColor,
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
                        activeColor: boxColor,
                        title: Text('Rio Bank',
                            style: TextStyle(color: smallText2)),
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
                SizedBox(height: 40,),
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
