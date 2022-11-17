import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:it_schedule/model/constants.dart';
import 'package:it_schedule/widget/login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              height: 800,
              width: 1200,
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: boxColor),
              child: LoginWidget(
                onClickedSignUp: () {},
            ),
          ),
        ),
      ),
    );
  }
}
