import 'dart:html';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/Widgets/login_widget.dart';
import 'package:flutter_application_1/Widgets/signup_widget.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? SignUpWidget(onClickedSignIn: toggle)
      : LoginWidget(onClickedSignUp: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
