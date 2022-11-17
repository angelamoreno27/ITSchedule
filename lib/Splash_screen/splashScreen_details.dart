// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:it_schedule/model/constants.dart';
import 'package:it_schedule/widget/new_login_screen.dart';
import 'package:it_schedule/widget/new_signin_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  List<Widget> pageChildren(double width) {
    return <Widget>[
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "WORK STUDY \n JUST GOT EASIER",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: largeText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Making Students Life Easier One Day At A Time.',
                style: TextStyle(fontSize: 16, color: smallText),
              ),
            ),
            Row(
              children: [
                GoToSignInPage(),
                SizedBox(
                  width: 10,
                ),
                GoToLoginPage(),
              ],
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Image.asset(
          'assets/images/SchoolLogo.png',
          width: width,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: pageChildren(constraints.biggest.width / 2),
        );
      } else {
        return Column(
          children: pageChildren(constraints.biggest.width),
        );
      }
    });
  }
}

class GoToSignInPage extends StatelessWidget {
  const GoToSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => SignUpPage())));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        child: Text(
          "SignIn",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}

class GoToLoginPage extends StatelessWidget {
  const GoToLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => LoginPage())));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        child: Text(
          "Login",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
