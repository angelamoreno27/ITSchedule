// ignore_for_file: unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_is_empty, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:it_schedule/admin/admin_panel.dart';
import 'package:it_schedule/model/constants.dart';

class ManagerPIN extends StatefulWidget {
  @override
  _ManagerPINState createState() => _ManagerPINState();
}

class _ManagerPINState extends State<ManagerPIN> {
  var selectedindex = 0;
  String code = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print("Code is $code");
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: matchBGColor,
        elevation: 0,
        leading: BackButton(),
      ),
      body: Column(
        children: [
          Container(
              height: height * 0.85,
              width: width,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "Please enter Manager PIN",
                              style: TextStyle(
                                fontSize: 40,
                                color: largeText,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DigitHolder(
                              width: width,
                              index: 0,
                              selectedIndex: selectedindex,
                              code: code,
                            ),
                            DigitHolder(
                                width: width,
                                index: 1,
                                selectedIndex: selectedindex,
                                code: code),
                            DigitHolder(
                                width: width,
                                index: 2,
                                selectedIndex: selectedindex,
                                code: code),
                            DigitHolder(
                                width: width,
                                index: 3,
                                selectedIndex: selectedindex,
                                code: code),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: boxColor),
                      width: 1200,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: backgroundColor),
                                          //height: double.maxFinite,
                                          onPressed: () {
                                            addDigit(1);
                                          },
                                          child: Text('1', style: textStyle)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                          // height: double.maxFinite,
                                          style: ElevatedButton.styleFrom(
                                              primary: backgroundColor),
                                          onPressed: () {
                                            addDigit(2);
                                          },
                                          child: Text('2', style: textStyle)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                          //height: double.maxFinite,
                                          style: ElevatedButton.styleFrom(
                                              primary: backgroundColor),
                                          onPressed: () {
                                            addDigit(3);
                                          },
                                          child: Text('3', style: textStyle)),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                          //height: double.maxFinite,
                                          style: ElevatedButton.styleFrom(
                                              primary: backgroundColor),
                                          onPressed: () {
                                            addDigit(4);
                                          },
                                          child: Text('4', style: textStyle)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(

                                          //height: double.maxFinite,
                                          style: ElevatedButton.styleFrom(
                                              primary: backgroundColor),
                                          onPressed: () {
                                            addDigit(5);
                                          },
                                          child: Text('5', style: textStyle)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                          //height: double.maxFinite,
                                          style: ElevatedButton.styleFrom(
                                              primary: backgroundColor),
                                          onPressed: () {
                                            addDigit(6);
                                          },
                                          child: Text('6', style: textStyle)),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                          // height: double.maxFinite,
                                          style: ElevatedButton.styleFrom(
                                              primary: backgroundColor),
                                          onPressed: () {
                                            addDigit(7);
                                          },
                                          child: Text('7', style: textStyle)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: backgroundColor),
                                          //height: double.maxFinite,
                                          onPressed: () {
                                            addDigit(8);
                                          },
                                          child: Text('8', style: textStyle)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: backgroundColor),
                                          // height: double.maxFinite,
                                          onPressed: () {
                                            addDigit(9);
                                          },
                                          child: Text('9', style: textStyle)),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                          //height: double.maxFinite,
                                          style: ElevatedButton.styleFrom(
                                              primary: backgroundColor),
                                          onPressed: () {
                                            backspace();
                                          },
                                          child: Icon(Icons.backspace_outlined,
                                              color: Colors.black, size: 30)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                          // height: double.maxFinite,
                                          style: ElevatedButton.styleFrom(
                                              primary: backgroundColor),
                                          onPressed: () {
                                            addDigit(0);
                                          },
                                          child: Text('0', style: textStyle)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                        //height: double.maxFinite,
                                        style: ElevatedButton.styleFrom(
                                            primary: backgroundColor),
                                        onPressed: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    AdminPanel())),
                                        child: Icon(Icons.check,
                                            color: Colors.black, size: 30),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  addDigit(int digit) {
    if (code.length > 3) {
      return;
    }
    setState(() {
      code = code + digit.toString();
      print('Code is $code');
      selectedindex = code.length;
    });
  }

  backspace() {
    if (code.length == 0) {
      return;
    }
    setState(() {
      code = code.substring(0, code.length - 1);
      selectedindex = code.length;
    });
  }
}

class DigitHolder extends StatelessWidget {
  final int selectedIndex;
  final int index;
  final String code;
  const DigitHolder({
    required this.selectedIndex,
    // required Key key,
    required this.width,
    required this.index,
    required this.code,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: width * 0.17,
      width: width * 0.17,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: index == selectedIndex ? backgroundColor : matchBGColor,
              offset: Offset(0, 0),
            )
          ]),
      child: code.length > index
          ? Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
            )
          : Container(),
    );
  }
}
