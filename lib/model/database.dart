import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:it_schedule/model/course.dart';

class ClassHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static saveUser(User? user) async {
    Map<int, List<String>> scheduleData = {};

    Map<String, dynamic> userData = {
      "name": user?.displayName,
      "email": user?.email,
      "last_login": user?.metadata.lastSignInTime,
      "role": "user",
      "schedule": scheduleData
    };

    final userRef = _db.collection("users").doc(user?.uid);

    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user?.metadata.lastSignInTime,
        "role": "student",
      });
    } else {
      await _db.collection("users").doc(user?.uid).set(userData);
    }
  }

  static saveSchedule(User? user, Map<String, List<String>> schedule) async {
    final userRef = _db.collection("users").doc(user?.uid);
    await userRef.update({
      "schedule": schedule,
    });
  }

  // static getSchedule(User? user) async {
  //   await _db.collection("users").doc(user?.uid).get().then((value) => /*schedule = value["schedule"]; */print(value.data()?["schedule"]["0"]));
  // }
}
