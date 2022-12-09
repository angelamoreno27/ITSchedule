// ignore_for_file: use_build_context_synchronously, unused_import, library_private_types_in_public_api, prefer_const_constructors, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth_email/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:it_schedule/Screens/calendar_new.dart';
import 'package:it_schedule/Screens/home_screen.dart';
import 'package:it_schedule/admin/admin_panel.dart';
import 'package:it_schedule/main.dart';
import 'package:it_schedule/model/constants.dart';
import 'package:it_schedule/utils.dart';
import "package:it_schedule/model/database.dart";

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          const Text(
            'Welcome Back',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                letterSpacing: 3,
                color: largeText2),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Please Use Your UTRGV Account, When Logging Back Into Your Account',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w100,
                letterSpacing: 3,
                color: smallText2),
          ),
          const SizedBox(
            height: 40,
          ),
          TextField(
            key: const Key("email_login"),
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                labelText: 'Enter UTRGV Email'),
          ),
          const SizedBox(height: 20),
          TextField(
            key: const Key("password_login"),
            controller: passwordController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 200),
          SizedBox(
            height: 75,
            width: 250,
            child: ElevatedButton.icon(
                key: const Key("sign_in"),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    padding: EdgeInsets.all(20),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: BtnColor),
                onPressed: signIn,
                icon: const Icon(Icons.login, size: 30),
                label: const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 24),
                )),
          ),
          const SizedBox(height: 40),
          RichText(
              text: TextSpan(
                  style: const TextStyle(color: smallText2),
                  text: 'New User ? ',
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    text: 'Create Account',
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: smallText2))
              ]))
        ],
      ));
  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      } else {
        return "Something Went Wrong.";
      }
    }
    User user = FirebaseAuth.instance.currentUser!;
    // print(user);

    // FutureBuilder(
    //   future: ClassHelper.getSchedule(user),
    //   builder: (context, snapshot) {

    //   },
    // );
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => HomePage())));
  }
}
