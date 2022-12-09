// ignore_for_file: unused_import, file_names, avoid_web_libraries_in_flutter, deprecated_member_use, prefer_const_constructors, use_build_context_synchronously, curly_braces_in_flow_control_structures, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:html';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:it_schedule/model/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:it_schedule/model/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:it_schedule/model/database.dart";
import 'package:it_schedule/main.dart';

class CampusScheduleScreen extends StatefulWidget {
  final String location;
  const CampusScheduleScreen({
    Key? key,
    required this.location,
  }) : super(key: key);
  @override
  State<CampusScheduleScreen> createState() => _CampusScheduleScreenState();
}

class _CampusScheduleScreenState extends State<CampusScheduleScreen> {
  List<String>weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
  final CollectionReference _students = FirebaseFirestore.instance.collection('users');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Schedule Page'),
        backgroundColor: backgroundColor,
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: matchBGColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minimumSize: Size(350, 60)),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainPage()));                      
            },
            child: const Text("Sign Out", style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w800)
            )
          ),        
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("All ${widget.location} Shifts"),
            StreamBuilder(
              stream: _students.snapshots(),
              builder: (context, snapshot) {
              if(snapshot.hasData) {
                Map<String, List<String>> locationShifts = {};

                for(int i = 0; i < snapshot.data!.docs.length; i++) {
        if(snapshot.data!.docs[i]['role'] == "student" && snapshot.data!.docs[i]['location'].length > 0)
        	if (snapshot.data!.docs[i]['location'][0].toUpperCase() + snapshot.data!.docs[i]['location'].substring(1) == widget.location)   {
                    // check their schedule and add their shifts to campus schedule if they work that day
                    for(int j = 0; j < 5; j++) {

      // for(int i = 0; i < snapshot.data!.docs.length; i++)
      //   if(snapshot.data!.docs[i]['role']

                      if(snapshot.data!.docs[i]['schedule'][j.toString()] != null) {
                        for(int k = 0; k < snapshot.data!.docs[i]['schedule'][j.toString()].length; k+=2) {
                          if((snapshot.data!.docs[i]['schedule'][j.toString()][k+1] == "Possible Worktime" || snapshot.data!.docs[i]['schedule'][j.toString()][k+1] == "Added Worktime") && snapshot.data!.docs[i]['schedule'][j.toString()][k + 2] != 1.toString()) {
                            if(locationShifts[j.toString()]  == null) {
                              locationShifts[j.toString()]  = [snapshot.data!.docs[i]['name'] + " " + snapshot.data!.docs[i]['schedule'][j.toString()][k] + " " + snapshot.data!.docs[i]['schedule'][j.toString()][k + 3]];
                            }
                            else {
                              locationShifts[j.toString()] ?.add(snapshot.data!.docs[i]['name'] + " " + snapshot.data!.docs[i]['schedule'][j.toString()][k] + " " + snapshot.data!.docs[i]['schedule'][j.toString()][k + 3]);
                            }
                          }
                        }
                      }
                    }
                  }
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    print(index);
                      return InkWell(
                        
                        child: // Container(
                          Wrap( 
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              Spacer(flex: 1),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(weekdays[index],
                                  style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w800),
                                  ),      
                                  if(locationShifts[index.toString()] != null)
                                    for(int j = 0; j < locationShifts[index.toString()]!.length; j++)
                                      Center(
                                        child: Text(locationShifts[index.toString()]![j],
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w800)
                                      )),
                                ],
                              ),
                              Spacer(flex: 1),
                            ],
                          )
                        //   width: 200,
                        //   height: 200,
                        //   margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        //   //color: Colors.blue[300],
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(20),
                        //     boxShadow: [
                        //       BoxShadow(
                        //           spreadRadius: 2,
                        //           color: Colors.blue.withOpacity(0.1),
                        //           blurRadius: 2)
                        //     ]
                        //   ),
                        //   child: Column(
                        //     mainAxisSize: MainAxisSize.min,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Text(weekdays[index]),                            
                        //       if(locationShifts[index.toString()] != null)
                        //         for(int j = 0; j < locationShifts[index.toString()]!.length; j++)
                        //           Text(locationShifts[index.toString()]![j], style: TextStyle(color: Colors.red)),
                        //     ],
                        //   ),
                        // ),
                      );
                  }
                );
                }
                else
                  return Text("Please wait...");
            }),

                //             Text(
                //   user.email!,
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),

            Padding(
              padding: const EdgeInsets.only(bottom: 10),

              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                ]
              ),
            )
          ]
        )
      )
    );
  }
}
