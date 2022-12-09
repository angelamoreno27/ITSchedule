// ignore_for_file: unused_import, file_names, avoid_web_libraries_in_flutter, prefer_const_constructors

import 'dart:html';

import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const _DrawerItem('Home'),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Divider(
                  color: Colors.blue[400],
                  thickness: 2,
                ),
              ),
              const _DrawerItem('Profile'),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Divider(
                  color: Colors.blue[400],
                  thickness: 2,
                ),
              ),
              const _DrawerItem('SignOut'),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Divider(
                  color: Colors.blue[400],
                  thickness: 2,
                ),
              ),
              const Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Text Here',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  const _DrawerItem(this.title);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
    );
  }
}
