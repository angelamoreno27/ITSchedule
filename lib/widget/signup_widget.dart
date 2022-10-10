import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:it_schedule/Screens/home_screen.dart';
import 'package:it_schedule/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:it_schedule/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:firebase_options/firebase_options.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpassController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpassController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Text(
                key: Key("welcome"),
                'Hey There, \n Welcome',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              TextFormField(
                key: Key("email"),
                controller: emailController,
                cursorColor: Colors.blue,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
              SizedBox(height: 4),
              TextFormField(
                key: Key("password"),
                controller: passwordController,
                cursorColor: Colors.blue,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Enter minimum of 6 characters'
                    : null,
              ),
              SizedBox(height: 4),
              TextFormField(
                key: Key("confirm_pass"),
                controller: confirmpassController,
                cursorColor: Colors.blue,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Confirm password'),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != passwordController.text
                    ? 'Passwords do not match'
                    : null,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                icon: Icon(Icons.arrow_forward, size: 32),
                label: Text('Sign Up', style: TextStyle(fontSize: 24)),
                key: Key("sign_up"),
                onPressed: signUp,
              ),
              SizedBox(height: 20),
              RichText(
                  key: Key("login_btn"),
                  text: TextSpan(
                      style: TextStyle(color: Colors.blue),
                      text: 'Already have an account? ',
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignIn,
                            text: 'Log In',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Theme.of(context).colorScheme.secondary))
                      ]))
            ],
          )));
  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        //confirmpassword: confirmpassController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      //Utils.showSnackBar(e.message);
      e.toString();
      // Fluttertoast.showToast(msg: e.message);
    }
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => HomePage())));
  }
}
