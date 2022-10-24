import 'package:flutter/material.dart';
import 'user_screen.dart';
import 'class_hours_screen.dart';
import 'calendar_new.dart';
import 'student_info.dart';

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
                style: TextStyle(
                    fontSize: 20, color: Colors.blue, fontFamily: 'arial'),
                key: Key('main')),
            Container(
                child: Column(
              children: [
                CheckboxListTile(
                    key: Key('edinburg-btn'),
                    title:
                        Text('Edinburg', style: TextStyle(color: Colors.blue)),
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
                CheckboxListTile(
                    key: Key('brownsville-btn'),
                    title: Text('Brownsville',
                        style: TextStyle(color: Colors.blue)),
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
                CheckboxListTile(
                    key: Key('riobank-btn'),
                    title:
                        Text('Rio Bank', style: TextStyle(color: Colors.blue)),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: riobank,
                    onChanged: (bool? value) {
                      setState(() {
                        riobank = value;
                        edinburg = false;
                        brownsville = false;
                        location = 'edinburg';
                      });
                    }),
              ],
            )),
            ElevatedButton(
                key: Key('continueDeviceButton'),
                onPressed: // brownsville || edinburg || riobank ?
                    () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StudentInfo()));
                }

                //  Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => ClassHoursScreen()));
                // }

                //: null,
                ,
                style: ElevatedButton.styleFrom(
                    primary: // brownsville || edinburg || riobank ?
                        Colors.blue
                    // : Colors.grey,
                    ),
                child: Text('Continue'))
          ],
        )));
  }
}
