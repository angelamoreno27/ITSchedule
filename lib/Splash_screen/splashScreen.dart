// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:it_schedule/Screens/home_screen.dart';
import 'package:it_schedule/Splash_screen/centeredView.dart';
import 'package:it_schedule/page/auth_page.dart';
import 'package:it_schedule/widget/responsive.dart';
import 'package:it_schedule/widget/signup_widget.dart';
import '../widget/login_widget.dart';
import 'navigationBar.dart';
import 'menuDrawer.dart';
import 'splashScreen_details.dart';
import 'package:it_schedule/model/constants.dart';

class splashScreen extends StatefulWidget {
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final screenSizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        // appBar: ResponsiveWidget.isMoblie(context)
        //     ? AppBar(
        //         iconTheme: IconThemeData(color: Colors.black),
        //         backgroundColor: backgroundColor,
        //         elevation: 0,
        //         centerTitle: true,
        //         title: const Text(
        //           'IT_Schedule',
        //           style: TextStyle(
        //             color: navBar_largeText,
        //             fontWeight: FontWeight.w900,
        //             fontSize: 26,
        //           ),
        //         ),
        //       )
        //     : PreferredSize(
        //         preferredSize: Size(screenSize.width, 70),
        //         child: TopBarContents(),
        //       ),
        //drawer: const MenuDrawer(),
        backgroundColor: backgroundColor,
        body: splashScreenBody());
  }
}

class splashScreenBody extends StatelessWidget {
  const splashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: SafeArea(
          child: ResponsiveWidget(
              desktop: Row(
            children: [const Expanded(child: LandingPage())],
          )),
        ),
      ),
    );
  }
}

class LoginAndSignUpButton extends StatelessWidget {
  const LoginAndSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
            tag: 'login-btn',
            child: ElevatedButton(
              // working on routing
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return AuthPage();
                })));
              },
              style: ElevatedButton.styleFrom(
                  primary: backgroundColor, elevation: 0),
              child: Text('Login'.toUpperCase(),
                  style: TextStyle(color: Colors.black)),
            )),
        const SizedBox(
          width: 20,
          height: 16,
        ),
        ElevatedButton(
            onPressed: (() {}),
            style: ElevatedButton.styleFrom(
                primary: backgroundColor, elevation: 0),
            child: Text(
              "Sign Up".toUpperCase(),
              style: TextStyle(color: Colors.black),
            ))
      ],
    );
  }
}
