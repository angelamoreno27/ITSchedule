import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:it_schedule/model/course.dart';
import 'dart:convert';


class ClassHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static saveName(User? user, String name) async {
    final userRef = _db.collection("users").doc(user?.uid);
    await userRef.set({
      "name": name,
      "email": user?.email,
      "last_login": user?.metadata.lastSignInTime,
      "role": "user",
      "schedule": {},
      "constantSchedule" : {},
      "location": ""
    });
  }

  static saveUser(User? user) async {
    Map<int, List<String>> scheduleData = {};

    Map<String, dynamic> userData = {
      "email": user?.email,
      "last_login": user?.metadata.lastSignInTime,
      "role": "student",
      "schedule": scheduleData,
      "constantSchedule" : scheduleData
    };

    final userRef = _db.collection("users").doc(user?.uid);

    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user?.metadata.lastSignInTime,
        // "role": "student",
      });
    } else {
      await _db.collection("users").doc(user?.uid).update(userData);
    }
  }

  static saveSchedule(User? user, Map<String, List<String>> schedule) async {
    final userRef = _db.collection("users").doc(user?.uid);
    await userRef.update({
      "schedule": schedule,
      "constantSchedule" : schedule
    });
  }

  static saveManagerSchedule(String userId, Map<String, List<String>> schedule) async {
    final userRef = _db.collection("users").doc(userId);
    await userRef.update({
      "schedule": schedule,
    });
  }

  Future<Map<String, dynamic>> getSchedule(User? user) async {
    // await _db.collection("users").doc(user?.uid).get().then((value) => /*schedule = value["schedule"]; */print(value.data()?["schedule"]));
    Map<String, dynamic> schedule = {};
    await _db.collection("users").doc(user?.uid).get().then((value) => /*schedule = value["schedule"]; */ schedule = value.data()?["schedule"]);
    return schedule;
  }

  Future<Map<String, dynamic>> getManagerSchedule(String userId) async {
    // await _db.collection("users").doc(user?.uid).get().then((value) => /*schedule = value["schedule"]; */print(value.data()?["schedule"]));
    Map<String, dynamic> schedule = {};
    await _db.collection("users").doc(userId).get().then((value) => /*schedule = value["schedule"]; */ schedule = value.data()?["schedule"]);
    return schedule;
  }

  static saveLocation(User? user, String location) async {
    final userRef = _db.collection("users").doc(user?.uid);
    await userRef.update({
      "location": location,
    });
  }

  Future<String> getLocation(User? user) async {
    // await _db.collection("users").doc(user?.uid).get().then((value) => /*schedule = value["schedule"]; */print(value.data()?["schedule"]));
    String location = "";
    await _db.collection("users").doc(user?.uid).get().then((value) => /*schedule = value["schedule"]; */ location = value.data()?["location"]);
    return location;
  }

  static saveRole(User? user, String role) async {
    final userRef = _db.collection("users").doc(user?.uid);
    await userRef.update({
      "role": role,
    });
  }

  Future<String> getRole(User? user) async {
    // await _db.collection("users").doc(user?.uid).get().then((value) => /*schedule = value["schedule"]; */print(value.data()?["schedule"]));
    String role = "";
    await _db.collection("users").doc(user?.uid).get().then((value) => /*schedule = value["schedule"]; */ role = value.data()?["role"]);
    return role;
  }

}
