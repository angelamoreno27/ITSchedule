import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth_email/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:it_schedule/Screens/calendar_new.dart';
import 'package:it_schedule/main.dart';
import 'package:it_schedule/utils.dart';

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
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 60),
          Text(
            'Hey There, \n Welcome Back',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40,
          ),
          TextField(
            key: Key("email_login"),
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          SizedBox(height: 4),
          TextField(
            key: Key("password_login"),
            controller: passwordController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
              key: Key("sign_in"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: signIn,
              icon: Icon(Icons.lock_open, size: 32),
              label: Text(
                'Sign In',
                style: TextStyle(fontSize: 24),
              )),
          SizedBox(height: 20),
          RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.blue),
                  text: 'New User? ',
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    text: 'Create Account',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.secondary))
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
      print(e);

      Utils.showSnackBar(e.message);
    }
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => CalendarScreen())));
  }
}
