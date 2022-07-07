import 'dart:js';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_browser.dart';

class Utils {
  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);
    return '$date $time';
  }

  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);

    return '$date';
  }

  static String toTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);

    return '$time';
  }

  static showSnackBar(String? text) {
    final messengerKey = GlobalKey<ScaffoldMessengerState>();

    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
