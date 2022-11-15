import 'dart:html';

import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget desktop;
  final Widget? tablet;
  final Widget? moblie;

  const ResponsiveWidget(
      {Key? key, required this.desktop, this.tablet, this.moblie})
      : super(key: key);

  static bool isMoblie(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width < 600 &&
        MediaQuery.of(context).size.width > 1200;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return desktop;
        } else if (constraints.maxWidth <= 1200 &&
            constraints.maxWidth >= 600) {
          return tablet ?? desktop;
        } else {
          return moblie ?? desktop;
        }
      },
    );
  }
}
