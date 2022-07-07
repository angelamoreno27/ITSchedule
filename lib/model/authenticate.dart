/*import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj baserd on Firebase usr
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(id: user.id) : null;
  }

  // auth change user stream

  Stream<User> get user {
    return _auth.onAuthStateChange.map(_userFromFirebaseUser(user));
  }
}

Future registerWithEmailAndPassword(String email, String password)  async{
  try {
    AuthResult result = await _auth.createUserWithEmailAndPassword(email,);
    FirebaseUser

  }
}*/