// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CampusScreen extends StatefulWidget {
  const CampusScreen({super.key});

  @override
  State<CampusScreen> createState() => _CampusScreenState();
}

class _CampusScreenState extends State<CampusScreen> {
  bool? _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Text(
              'What Campus do you work at?', // Question above

              style: TextStyle(fontSize: 25),
            ),
          ),
        ),

        // Location Part
        Column(
          children: <Widget>[
            Center(
              child: CheckboxListTile(
                title: const Text('Brownsville'),
                value: _isChecked,
                onChanged: (bool? newBValue) {
                  setState(() {
                    _isChecked = newBValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Center(
              child: CheckboxListTile(
                title: const Text('Edinburg'),
                value: _isChecked,
                onChanged: (bool? newEValue) {
                  setState(() {
                    _isChecked = newEValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
