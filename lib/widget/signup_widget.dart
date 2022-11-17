import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:it_schedule/Screens/home_screen.dart';
import 'package:it_schedule/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:it_schedule/model/constants.dart';
import 'package:it_schedule/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
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
  final fullnameController = TextEditingController();
  final sidController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpassController.dispose();
    fullnameController.dispose();
    sidController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Text(
                key: Key("welcome"),
                'Create An Account ',
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
                'Please Use Your UTRGV Credentials When Creating The Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                    letterSpacing: 3,
                    color: smallText2),
              ),
              const SizedBox(height: 40),
              TextFormField(
                key: const Key("full_name"),
                controller: fullnameController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    labelText: 'Full Name'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                key: const Key("student_id"),
                controller: sidController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    labelText: 'UTRGV Student ID Number'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                key: const Key("email"),
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    labelText: 'UTRGV Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                key: const Key("password"),
                controller: passwordController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    labelText: 'Password'),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Enter minimum of 6 characters'
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                key: const Key("confirm_pass"),
                controller: confirmpassController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    labelText: 'Confirm Password'),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != passwordController.text
                    ? 'Passwords do not match'
                    : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 75,
                width: 250,
                child: ElevatedButton.icon(
                    key: const Key("sign_up"),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        padding: const EdgeInsets.all(20),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: BtnColor),
                    onPressed: signUp,
                    icon: const Icon(Icons.lock_open, size: 30),
                    label: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 24),
                    )),
              ),
              const SizedBox(height: 20),
              RichText(
                  key: const Key("login_btn"),
                  text: TextSpan(
                      style: const TextStyle(color: smallText2),
                      text: 'Already have an account? ',
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignIn,
                            text: 'Log In',
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: smallText2))
                      ]))
            ],
          )));
  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
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
