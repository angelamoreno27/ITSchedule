// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:it_schedule/model/constants.dart';
import 'dart:convert';

import 'package:it_schedule/model/database.dart';

class TimeSlotsScreen extends StatefulWidget {
  final DocumentSnapshot docSnapshot;
  const TimeSlotsScreen(this.docSnapshot, {super.key});
  @override
  State<TimeSlotsScreen> createState() => _TimeSlotsScreenState(docSnapshot);
}

class _TimeSlotsScreenState extends State<TimeSlotsScreen> {
// class TimeSlots extends StatelessWidget {

  DocumentSnapshot docSnapshot;
  _TimeSlotsScreenState(this.docSnapshot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text("Edit ${docSnapshot['name']} Time Slots"),
          backgroundColor: matchBGColor,
        ),
        body: _classSchedule(context, widget.docSnapshot));
  }
}

Widget _classSchedule(BuildContext context, DocumentSnapshot docSnapshot) {
  List<String> weekdays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];
  String startHourValue = '8';
  String startMinuteValue = '30';
  String finishHourValue = '9';
  String finishMinuteValue = '30';
  String earlyHourValue = '8';
  String earlyMinuteValue = '30';
  String lateHourValue = '9';
  String lateMinuteValue = '30';
  String day = "";
  int shiftIndex = 0;
  bool checkValue = false;
  List<String> hours = List<String>.generate(12, (i) => '${i + 1}');
  List<String> minutes = List<String>.generate(12, (i) => '${i * 5}');
  Map<String, List<String>> firebaseSchedule = {};
  bool validUpdate = false;
  String currentJob = "";
  List<String> jobs = ["Job Not Chosen", "MASH", "Phones", "Desktop", "Walkup"];

  // for(int x = 0; x < 5; x++) {
  //   if(docSnapshot['schedule'][x.toString()] != null) {
  //     for(int y = 0; y < docSnapshot['schedule'][x.toString()].length; y++) {
  //       if(firebaseSchedule[x.toString()] == null)
  //         firebaseSchedule[x.toString()] = [docSnapshot['schedule'][x.toString()][y]];
  //       else
  //         firebaseSchedule[x.toString()]?.add(docSnapshot['schedule'][x.toString()][y]);
  //     }
  //   }
  // }

  return Column(
    children: <Widget>[
      FutureBuilder(
          // https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html
          future: ClassHelper().getManagerSchedule(docSnapshot.id),
          builder: (context, snapshot) {
            List<Widget> shifts;
            if (snapshot.hasData) {
              Map<String, dynamic> schedule = snapshot.data!;
              for (int x = 0; x < 5; x++) {
                if (schedule[x.toString()] != null) {
                  for (int y = 0; y < schedule[x.toString()].length; y++) {
                    if (firebaseSchedule[x.toString()] == null)
                      firebaseSchedule[x.toString()] = [
                        schedule[x.toString()][y]
                      ];
                    else
                      firebaseSchedule[x.toString()]
                          ?.add(schedule[x.toString()][y]);
                  }
                }
              }
              shifts = <Widget>[
                for (int i = 0; i < 5; i++) ...[
                  Text(weekdays[i],
                      style:
                          TextStyle(fontSize: 60, fontWeight: FontWeight.w800)),
                  if (firebaseSchedule[i.toString()] != null)
                    for (int j = 0;
                        j < firebaseSchedule[i.toString()]!.length;
                        j += 2) ...[
                      if (firebaseSchedule[i.toString()]![j + 1] ==
                              "Possible Worktime" ||
                          firebaseSchedule[i.toString()]![j + 1] ==
                              "Added Worktime")
                        Container(
                            color: firebaseSchedule[i.toString()]![j + 2] !=
                                    1.toString()
                                ? boxColor
                                : backgroundColor,
                            child: Container(
                              child: Row(
                                children: [
                                  //Spacer(flex: 1),
                                  Spacer(flex: 2),
                                  Text("${firebaseSchedule[i.toString()]![j]}",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w800)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      "${firebaseSchedule[i.toString()]![j + 1]}",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w800)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      "${firebaseSchedule[i.toString()]![j + 3]}",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w800)),
                                  Spacer(flex: 1),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          minimumSize: Size(50, 50)),
                                      onPressed: firebaseSchedule[
                                                  i.toString()]![j + 1] ==
                                              "Possible Worktime"
                                          ? () {
                                              firebaseSchedule[i.toString()]!
                                                  .insertAll(j, [
                                                firebaseSchedule[i.toString()]![
                                                    j],
                                                "Added Worktime",
                                                firebaseSchedule[i.toString()]![
                                                    j + 2],
                                                firebaseSchedule[i.toString()]![
                                                    j + 3]
                                              ]);
                                              ClassHelper.saveManagerSchedule(
                                                  docSnapshot.id,
                                                  firebaseSchedule);
                                              ClassHelper
                                                  .insertConstantScheduleElement(
                                                      docSnapshot.id,
                                                      i.toString(),
                                                      j);
                                              Navigator.pop(context);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TimeSlotsScreen(
                                                              docSnapshot)));
                                            }
                                          : null,
                                      child: const Text("Copy")),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          minimumSize: Size(50, 50)),
                                      onPressed: firebaseSchedule[
                                                  i.toString()]![j + 1] ==
                                              "Added Worktime"
                                          ? () {
                                              firebaseSchedule[i.toString()]!
                                                  .removeRange(j, j + 4);
                                              ClassHelper.saveManagerSchedule(
                                                  docSnapshot.id,
                                                  firebaseSchedule);
                                              ClassHelper
                                                  .removeConstantScheduleElement(
                                                      docSnapshot.id,
                                                      i.toString(),
                                                      j);
                                              Navigator.pop(context);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TimeSlotsScreen(
                                                              docSnapshot)));
                                            }
                                          : null,
                                      child: const Text("Remove")),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          minimumSize: Size(50, 50)),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  content: Center(
                                                      heightFactor: 1,
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2),
                                                          child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                // ClassHelper.getConstantSchedule().then(),

                                                                // <Widget>[Text("Please Wait...")]
                                                                FutureBuilder(
                                                                    future: ClassHelper().getConstantSchedule(
                                                                        docSnapshot
                                                                            .id),
                                                                    builder:
                                                                        (context,
                                                                            snap) {
                                                                      if (snap
                                                                          .hasData) {
                                                                        Map<String,
                                                                                dynamic>
                                                                            constSched =
                                                                            snap.data!;
                                                                        // print(constSched);
                                                                        // print("\n\n");
                                                                        // print(firebaseSchedule);
                                                                        // print("\n\n");
                                                                        // print(docSnapshot['schedule']);
                                                                        return Column(
                                                                            children: <Widget>[
                                                                              Text("Max Shift Time"),
                                                                              Text("${constSched[i.toString()][j]}"),
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Text("Current Shift Time"),
                                                                              Text("${firebaseSchedule[i.toString()]![j]}"),
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Text("New Shift Time"),
                                                                              Container(
                                                                                  height: 40,
                                                                                  child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                                                                    StatefulBuilder(builder: ((context, setState) {
                                                                                      day = i.toString();
                                                                                      shiftIndex = j;
                                                                                      startHourValue = firebaseSchedule[i.toString()]![j].substring(0, firebaseSchedule[i.toString()]![j].indexOf("-")).substring(0, firebaseSchedule[i.toString()]![j].substring(0, firebaseSchedule[i.toString()]![j].indexOf("-")).indexOf(":"));
                                                                                      startMinuteValue = firebaseSchedule[i.toString()]![j].substring(0, firebaseSchedule[i.toString()]![j].indexOf("-")).substring(firebaseSchedule[i.toString()]![j].substring(0, firebaseSchedule[i.toString()]![j].indexOf("-")).indexOf(":") + 1);
                                                                                      finishHourValue = firebaseSchedule[i.toString()]![j].substring(firebaseSchedule[i.toString()]![j].indexOf("-") + 1).substring(0, firebaseSchedule[i.toString()]![j].substring(firebaseSchedule[i.toString()]![j].indexOf("-") + 1).indexOf(":"));
                                                                                      finishMinuteValue = firebaseSchedule[i.toString()]![j].substring(firebaseSchedule[i.toString()]![j].indexOf("-") + 1).substring(firebaseSchedule[i.toString()]![j].substring(firebaseSchedule[i.toString()]![j].indexOf("-") + 1).indexOf(":") + 1);

                                                                                      // for(int x = j; x > 0; x--) {
                                                                                      //   if(firebaseSchedule[i.toString()]![x] == "Possible Worktime")

                                                                                      // }
                                                                                      earlyHourValue = constSched[i.toString()]![j].substring(0, constSched[i.toString()]![j].indexOf("-")).substring(0, constSched[i.toString()]![j].substring(0, constSched[i.toString()]![j].indexOf("-")).indexOf(":"));
                                                                                      earlyMinuteValue = constSched[i.toString()]![j].substring(0, constSched[i.toString()]![j].indexOf("-")).substring(constSched[i.toString()]![j].substring(0, constSched[i.toString()]![j].indexOf("-")).indexOf(":") + 1);
                                                                                      lateHourValue = constSched[i.toString()]![j].substring(constSched[i.toString()]![j].indexOf("-") + 1).substring(0, constSched[i.toString()]![j].substring(constSched[i.toString()]![j].indexOf("-") + 1).indexOf(":"));
                                                                                      lateMinuteValue = constSched[i.toString()]![j].substring(constSched[i.toString()]![j].indexOf("-") + 1).substring(constSched[i.toString()]![j].substring(constSched[i.toString()]![j].indexOf("-") + 1).indexOf(":") + 1);
                                                                                      // print(earlyHourValue + earlyMinuteValue + lateHourValue + lateMinuteValue);
                                                                                      // print(startHourValue + startMinuteValue + finishHourValue + finishMinuteValue);
                                                                                      checkValue = firebaseSchedule[i.toString()]![j + 2] == 1.toString() ? true : false;
                                                                                      currentJob = firebaseSchedule[i.toString()]![j + 3];
                                                                                      setState(
                                                                                        () {},
                                                                                      );
                                                                                      return Text("");
                                                                                    })),
                                                                                    StatefulBuilder(builder: ((context, setState) {
                                                                                      return DropdownButton<String>(
                                                                                        // iconSize: 0,
                                                                                        icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
                                                                                        value: startHourValue,
                                                                                        onChanged: (String? value) {
                                                                                          setState(() {
                                                                                            startHourValue = value!;
                                                                                          });
                                                                                        },
                                                                                        items: hours.map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(
                                                                                              value,
                                                                                              style: const TextStyle(fontSize: 25),
                                                                                            ),
                                                                                          );
                                                                                        }).toList(),
                                                                                      );
                                                                                    })),
                                                                                    const Text(
                                                                                      ':',
                                                                                      style: TextStyle(fontSize: 25),
                                                                                    ),
                                                                                    StatefulBuilder(builder: ((context, setState) {
                                                                                      return DropdownButton<String>(
                                                                                        // iconSize: 0,
                                                                                        icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
                                                                                        value: startMinuteValue,
                                                                                        onChanged: (String? value) {
                                                                                          setState(() {
                                                                                            startMinuteValue = value!;
                                                                                          });
                                                                                        },
                                                                                        items: minutes.map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: ('0' + value).substring(value.length + 1 - 2),
                                                                                            child: Text(
                                                                                              ('0' + value).substring(value.length + 1 - 2),
                                                                                              style: const TextStyle(fontSize: 25),
                                                                                            ),
                                                                                          );
                                                                                        }).toList(),
                                                                                      );
                                                                                    })),
                                                                                    const Text(
                                                                                      '-',
                                                                                      style: TextStyle(fontSize: 25),
                                                                                    ),
                                                                                    StatefulBuilder(builder: ((context, setState) {
                                                                                      return DropdownButton<String>(
                                                                                        // iconSize: 0,
                                                                                        icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
                                                                                        value: finishHourValue,
                                                                                        onChanged: (String? value) {
                                                                                          setState(() {
                                                                                            finishHourValue = value!;
                                                                                          });
                                                                                        },
                                                                                        items: hours.map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(
                                                                                              value,
                                                                                              style: const TextStyle(fontSize: 25),
                                                                                            ),
                                                                                          );
                                                                                        }).toList(),
                                                                                      );
                                                                                    })),
                                                                                    const Text(
                                                                                      ':',
                                                                                      style: TextStyle(fontSize: 25),
                                                                                    ),
                                                                                    StatefulBuilder(builder: ((context, setState) {
                                                                                      return DropdownButton<String>(
                                                                                        // iconSize: 0,
                                                                                        icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
                                                                                        value: finishMinuteValue,
                                                                                        onChanged: (String? value) {
                                                                                          setState(() {
                                                                                            finishMinuteValue = value!;
                                                                                          });
                                                                                        },
                                                                                        items: minutes.map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: ('0' + value).substring(value.length + 1 - 2),
                                                                                            child: Text(
                                                                                              ('0' + value).substring(value.length + 1 - 2),
                                                                                              style: const TextStyle(fontSize: 25),
                                                                                            ),
                                                                                          );
                                                                                        }).toList(),
                                                                                      );
                                                                                    })),
                                                                                  ])),

                                                                              Text("Current Job"),
                                                                              Text("${firebaseSchedule[i.toString()]![j + 3]}"),
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),

                                                                              Text("New Job"),
                                                                              // MASH Phones Desktop Walkup
                                                                              StatefulBuilder(builder: ((context, setState) {
                                                                                return DropdownButton<String>(
                                                                                  icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
                                                                                  value: currentJob,
                                                                                  onChanged: (String? value) {
                                                                                    setState(() {
                                                                                      currentJob = value!;
                                                                                    });
                                                                                  },
                                                                                  items: jobs.map<DropdownMenuItem<String>>((String value) {
                                                                                    return DropdownMenuItem<String>(
                                                                                      value: value,
                                                                                      child: Text(
                                                                                        value,
                                                                                        style: const TextStyle(fontSize: 25),
                                                                                      ),
                                                                                    );
                                                                                  }).toList(),
                                                                                );
                                                                              })),
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Text("Hide"),
                                                                              StatefulBuilder(builder: ((context, setState) {
                                                                                return Checkbox(
                                                                                    value: checkValue,
                                                                                    onChanged: (value) {
                                                                                      setState(() {
                                                                                        checkValue = value!;
                                                                                      });
                                                                                    });
                                                                              })),
                                                                            ]);
                                                                      } else
                                                                        return Text(
                                                                            "Loading...");
                                                                    }),
                                                              ]))),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text("Back"),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                    TextButton(
                                                      child:
                                                          const Text("Update"),
                                                      onPressed: () {
                                                        validUpdate = (int.parse(startHourValue) < 6 ? int.parse(startHourValue) + 12 : int.parse(startHourValue)) >= (int.parse(earlyHourValue) < 6 ? int.parse(earlyHourValue) + 12 : int.parse(earlyHourValue)) &&
                                                            !((int.parse(startHourValue) < 6 ? int.parse(startHourValue) + 12 : int.parse(startHourValue)) == (int.parse(earlyHourValue) < 6 ? int.parse(earlyHourValue) + 12 : int.parse(earlyHourValue)) &&
                                                                int.parse(earlyMinuteValue) >
                                                                    int.parse(
                                                                        startMinuteValue)) &&
                                                            (int.parse(startHourValue) < 6 ? int.parse(startHourValue) + 12 : int.parse(startHourValue)) <
                                                                (int.parse(finishHourValue) < 6
                                                                    ? int.parse(finishHourValue) +
                                                                        12
                                                                    : int.parse(
                                                                        finishHourValue)) &&
                                                            (int.parse(startHourValue) < 6 ? int.parse(startHourValue) + 12 : int.parse(startHourValue)) <
                                                                (int.parse(lateHourValue) < 6
                                                                    ? int.parse(lateHourValue) +
                                                                        12
                                                                    : int.parse(
                                                                        lateHourValue)) &&
                                                            (int.parse(lateHourValue) < 6 ? int.parse(lateHourValue) + 12 : int.parse(lateHourValue)) >=
                                                                (int.parse(finishHourValue) <
                                                                        6
                                                                    ? int.parse(finishHourValue) +
                                                                        12
                                                                    : int.parse(finishHourValue)) &&
                                                            !((int.parse(lateHourValue) < 6 ? int.parse(lateHourValue) + 12 : int.parse(lateHourValue)) == (int.parse(finishHourValue) < 6 ? int.parse(finishHourValue) + 12 : int.parse(finishHourValue)) && int.parse(finishMinuteValue) > int.parse(lateMinuteValue));
                                                        if (validUpdate) {
                                                          String startTime =
                                                              startHourValue +
                                                                  ':' +
                                                                  ('0' + startMinuteValue)
                                                                      .substring(
                                                                          startMinuteValue.length +
                                                                              1 -
                                                                              2);
                                                          String finishTime =
                                                              finishHourValue +
                                                                  ':' +
                                                                  ('0' + finishMinuteValue)
                                                                      .substring(
                                                                          finishMinuteValue.length +
                                                                              1 -
                                                                              2);
                                                          firebaseSchedule[
                                                                      day]![
                                                                  shiftIndex] =
                                                              startTime +
                                                                  "-" +
                                                                  finishTime;
                                                          firebaseSchedule[
                                                                      day]![
                                                                  shiftIndex +
                                                                      2] =
                                                              checkValue
                                                                  ? "1"
                                                                  : "0";
                                                          firebaseSchedule[
                                                                      day]![
                                                                  shiftIndex +
                                                                      3] =
                                                              currentJob;
                                                          // print(firebaseSchedule[day]![shiftIndex]);

                                                          // ClassHelper.saveSchedule(user, firebaseSchedule);

                                                          ClassHelper
                                                              .saveManagerSchedule(
                                                                  docSnapshot
                                                                      .id,
                                                                  firebaseSchedule);
                                                          validUpdate = false;
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      TimeSlotsScreen(
                                                                          docSnapshot)));
                                                          // final CollectionReference _students = FirebaseFirestore.instance.collection('users');
                                                          // FirebaseFirestore _db = FirebaseFirestore.instance;
                                                          // _db.collection("users").get().then((querySnapshot) -> {
                                                          //   querySnapshot.forEach((doc) => {
                                                          //     ;
                                                          //   })
                                                          // })

                                                          // StreamBuilder (
                                                          //   stream: _students.snapshots(),
                                                          //   builder: (context, docSnap) {

                                                          //   if(docSnap.hasData) {
                                                          //     for(int q = 0; q < docSnap.data!.docs.length; q++)
                                                          //       if(docSnapshot.id == docSnap.data!.docs[q].id) {

                                                          //           print("cheetoes tacos t");
                                                          //       }
                                                          //         return Text("Done");
                                                          //     }
                                                          //     else
                                                          //       return Text("Please wait...");
                                                          // });

                                                          // final DocumentSnapshot docSnapshot = FirebaseFirestore.instance.collection('users').data!.docs[studentIndices[index]];

                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ));
                                      },
                                      child: const Text("Edit")),
                                  SizedBox(
                                    width: 60,
                                  ),
                                ],
                              ),
                            ))
                    ]
                ],
              ];
            } else
              shifts = <Widget>[Text("Please Wait...")];
            return Column(children: shifts);
          }) // Future Builder bracket and parentheses
    ],
  );
}
