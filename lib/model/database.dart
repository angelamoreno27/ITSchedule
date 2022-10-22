import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClassHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static saveUser(User? user) async {
    Map<String, dynamic> userData = {
      "name": user?.displayName,
      "email": user?.email,
      "last_login": user?.metadata.lastSignInTime,
      "role": "user",
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
}
