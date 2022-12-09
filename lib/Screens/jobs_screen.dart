// ignore_for_file: unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, non_constant_identifier_names, prefer_const_constructors, duplicate_ignore, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'user_screen.dart';

class JobsScreen extends StatefulWidget {
  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  bool? EDNphones = false;
  bool? EDNdesktop = false;
  bool? EDNwalkup = false;
  bool? MASH = false;
  bool? BRNphones = false;
  bool? BRNdesktop = false;
  bool? BRNwalkup = false;
  String job = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
      // ignore: prefer_const_constructors
      Text("See schedule for:",
          // ignore: prefer_const_constructors
          style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 255, 119, 0),
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold),
          key: Key('main')),
      Container(
        child: Column(
          children: [
            CheckboxListTile(
                title: Text('EDN - Phones',
                    style: TextStyle(color: Color.fromARGB(255, 255, 119, 0))),
                controlAffinity: ListTileControlAffinity.trailing,
                value: EDNphones,
                onChanged: (bool? value) {
                  setState(() {
                    EDNphones = value;
                    EDNdesktop = false;
                    EDNwalkup = false;
                    MASH = false;
                    BRNphones = false;
                    BRNdesktop = false;
                    BRNwalkup = false;
                    job = 'EDNphones';
                  });
                }),
            CheckboxListTile(
                title: Text('EDN - Desktop Support',
                    style: TextStyle(color: Color.fromARGB(255, 255, 119, 0))),
                controlAffinity: ListTileControlAffinity.trailing,
                value: EDNdesktop,
                onChanged: (bool? value) {
                  setState(() {
                    EDNphones = false;
                    EDNdesktop = value;
                    EDNwalkup = false;
                    MASH = false;
                    BRNphones = false;
                    BRNdesktop = false;
                    BRNwalkup = false;
                    job = 'EDNdesktop';
                  });
                }),
            CheckboxListTile(
                title: Text('EDN - Walkup Desk',
                    style: TextStyle(color: Color.fromARGB(255, 255, 119, 0))),
                controlAffinity: ListTileControlAffinity.trailing,
                value: EDNwalkup,
                onChanged: (bool? value) {
                  setState(() {
                    EDNphones = false;
                    EDNdesktop = false;
                    EDNwalkup = value;
                    MASH = false;
                    BRNphones = false;
                    BRNdesktop = false;
                    BRNwalkup = false;
                    job = 'EDNwalkup';
                  });
                }),
            CheckboxListTile(
                title: Text('MASH',
                    style: TextStyle(color: Color.fromARGB(255, 255, 119, 0))),
                controlAffinity: ListTileControlAffinity.trailing,
                value: MASH,
                onChanged: (bool? value) {
                  setState(() {
                    EDNphones = false;
                    EDNdesktop = false;
                    EDNwalkup = false;
                    MASH = value;
                    BRNphones = false;
                    BRNdesktop = false;
                    BRNwalkup = false;
                    job = 'MASH';
                  });
                }),
            CheckboxListTile(
                title: Text('BRN - Phones',
                    style: TextStyle(color: Color.fromARGB(255, 255, 119, 0))),
                controlAffinity: ListTileControlAffinity.trailing,
                value: BRNphones,
                onChanged: (bool? value) {
                  setState(() {
                    EDNphones = false;
                    EDNdesktop = false;
                    EDNwalkup = false;
                    MASH = false;
                    BRNphones = value;
                    BRNdesktop = false;
                    BRNwalkup = false;
                    job = 'BRNphones';
                  });
                }),
            CheckboxListTile(
                title: Text('BRN - Desktop Support',
                    style: TextStyle(color: Color.fromARGB(255, 255, 119, 0))),
                controlAffinity: ListTileControlAffinity.trailing,
                value: BRNdesktop,
                onChanged: (bool? value) {
                  setState(() {
                    EDNphones = false;
                    EDNdesktop = false;
                    EDNwalkup = false;
                    MASH = false;
                    BRNphones = false;
                    BRNdesktop = value;
                    BRNwalkup = false;
                    job = 'BRNdesktop';
                  });
                }),
            CheckboxListTile(
                title: Text('BRN - Walkup Desk',
                    style: TextStyle(color: Color.fromARGB(255, 255, 119, 0))),
                controlAffinity: ListTileControlAffinity.trailing,
                value: BRNwalkup,
                onChanged: (bool? value) {
                  setState(() {
                    EDNphones = false;
                    EDNdesktop = false;
                    EDNwalkup = false;
                    MASH = false;
                    BRNphones = false;
                    BRNdesktop = false;
                    BRNwalkup = value;
                    job = 'BRNwalkup';
                  });
                })
          ],
        ),
      )
    ])));
  }
}
