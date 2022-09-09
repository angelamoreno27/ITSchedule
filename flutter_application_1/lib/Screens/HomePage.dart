// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'Calendar.dart';
import 'SignInScreen.dart';
import 'LoginScreen.dart';
import 'Campus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List _screens = [
    SignUpScreen(),
    LoginScreen(),
    CalendarScreen(),
    CampusScreen()
  ];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IT Scheldule App',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('IT Schedule App'),
          ),
          body: _screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: _updateIndex,
            items: const [
              BottomNavigationBarItem(
                  label: "SignUp", icon: Icon(Icons.account_circle)),
              BottomNavigationBarItem(
                  label: "Login", icon: Icon(Icons.no_accounts)),
              BottomNavigationBarItem(
                  label: "Calendar", icon: Icon(Icons.calendar_month)),
              BottomNavigationBarItem(
                  label: "Campus", icon: Icon(Icons.school)),
            ],
          ),
        ));
  }
}
