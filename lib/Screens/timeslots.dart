import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import 'package:it_schedule/model/database.dart';

class TimeSlotsScreen extends StatefulWidget {
  final DocumentSnapshot docSnapshot;
  const TimeSlotsScreen(this.docSnapshot, {super.key});
  @override
  State<TimeSlotsScreen> createState() => _TimeSlotsScreenState();
}

class _TimeSlotsScreenState extends State<TimeSlotsScreen> {


// class TimeSlots extends StatelessWidget {

  // DocumentSnapshot docSnapshot;
  // _TimeSlotsScreenState(this.docSnapshot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Time Slots Page'),
          
        ),
        body: _classSchedule(context, widget.docSnapshot));
  }
}

Widget _classSchedule(BuildContext context, DocumentSnapshot docSnapshot) {
  List<String>weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
  String startHourValue = '8';
  String startMinuteValue = '30';
  String finishHourValue = '9';
  String finishMinuteValue = '30';
  String day = "";
  int shiftIndex = 0;
  List<String> hours = List<String>.generate(12, (i) => '${i + 1}');
  List<String> minutes = List<String>.generate(12, (i) => '${i * 5}');
  Map<String, List<String>> firebaseSchedule = {};

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
       if(snapshot.hasData) {
            Map<String,dynamic> schedule = snapshot.data!;
            for(int x = 0; x < 5; x++) {
              if(schedule[x.toString()] != null) {
                for(int y = 0; y < schedule[x.toString()].length; y++) {
                  if(firebaseSchedule[x.toString()] == null)
                    firebaseSchedule[x.toString()] = [schedule[x.toString()][y]];
                  else
                    firebaseSchedule[x.toString()]?.add(schedule[x.toString()][y]);
                }
              }
            }
            shifts = <Widget>[
            for(int i = 0; i < 5; i++) ...[
              Text(weekdays[i]),
              if(firebaseSchedule[i.toString()] != null)
              for(int j = 0; j < firebaseSchedule[i.toString()]!.length; j+=2)...[
                if(firebaseSchedule[i.toString()]![j+1] == "Possible Worktime")
                Row(
                  children: [
                    Spacer(flex: 1),
                    Spacer(flex: 2),
                    Text("${firebaseSchedule[i.toString()]![j]}"),
                    Text("${firebaseSchedule[i.toString()]![j+1]}"),
                    Spacer(flex: 1),

                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => 
                              AlertDialog(
                                content: Center(
                                  heightFactor: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text("Current Shift Time"),
                                        Text("${firebaseSchedule[i.toString()]![j]}"),
                                        Text("New Shift Time"),
                                        Container(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                            StatefulBuilder(builder: ((context, setState) {
                                              day = i.toString();
                                              shiftIndex = j;
                                              startHourValue = firebaseSchedule[i.toString()]![j].substring(0, firebaseSchedule[i.toString()]![j].indexOf("-")).substring(
                                                0, firebaseSchedule[i.toString()]![j].substring(0, firebaseSchedule[i.toString()]![j].indexOf("-")).indexOf(":"));
                                              startMinuteValue = firebaseSchedule[i.toString()]![j].substring(0, firebaseSchedule[i.toString()]![j].indexOf("-")).substring(
                                                firebaseSchedule[i.toString()]![j].substring(0, firebaseSchedule[i.toString()]![j].indexOf("-")).indexOf(":") + 1);
                                              finishHourValue = firebaseSchedule[i.toString()]![j].substring(firebaseSchedule[i.toString()]![j].indexOf("-") + 1).substring(
                                                0, firebaseSchedule[i.toString()]![j].substring(firebaseSchedule[i.toString()]![j].indexOf("-") + 1).indexOf(":"));
                                              finishMinuteValue = firebaseSchedule[i.toString()]![j].substring(firebaseSchedule[i.toString()]![j].indexOf("-") + 1).substring(
                                                firebaseSchedule[i.toString()]![j].substring(firebaseSchedule[i.toString()]![j].indexOf("-") + 1).indexOf(":") + 1);


                                              print("${startMinuteValue}  ${finishMinuteValue}");
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
                                                    child: Text(value, style: const TextStyle(fontSize: 25),),
                                                  )
                                                ;}).toList(),
                                              );
                                            })),


                                            const Text(':', style: TextStyle(fontSize: 25),),

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
                                                    child: Text(('0' + value).substring(value.length + 1 - 2), style: const TextStyle(fontSize: 25),),
                                                  )
                                                ;}).toList(),
                                              );
                                            })),

                                            const Text('-', style: TextStyle(fontSize: 25),),

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
                                                    child: Text(value, style: const TextStyle(fontSize: 25),),
                                                  )
                                                ;}).toList(),
                                              );
                                            })),

                                            const Text(':', style: TextStyle(fontSize: 25),),

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
                                                    child: Text(('0' + value).substring(value.length + 1 - 2), style: const TextStyle(fontSize: 25),),
                                                  )
                                                ;}).toList(),
                                              );
                                            })),
                                            ]
                                          )
                                        ),
                                      ]
                                    )
                                  )
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text("Back"),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  TextButton(
                                    child: const Text("Update"),
                                    onPressed: () {

                                      String startTime = startHourValue + ':' + ('0' + startMinuteValue).substring(startMinuteValue.length + 1 - 2);
                                      String finishTime = finishHourValue + ':' + ('0' + finishMinuteValue).substring(finishMinuteValue.length + 1 - 2);
                                      firebaseSchedule[day]![shiftIndex] = startTime + "-" + finishTime;
                                      print(firebaseSchedule[day]![shiftIndex]);

                                      // ClassHelper.saveSchedule(user, firebaseSchedule);


                                      ClassHelper.saveManagerSchedule(docSnapshot.id, firebaseSchedule);
                                      Navigator.pop(context);
                                      Navigator.pop(context);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TimeSlotsScreen(docSnapshot)));
                                    },
                                  ),
                                  
                                ],
                              )
                          );
                        },
                        child: const Text("Edit")
                      ),
                  ],
                )
              ]
            ],
            TextButton(
              child: const Text("Update Shifts"),
              onPressed: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TimeSlotsScreen(docSnapshot)))
                },
            ),  ];
          }
          else
            shifts = <Widget>[Text("Please Wait...")];
          return Column(
            children: shifts
          );
      }) // Future Builder bracket and parentheses
    ],
  );
}
