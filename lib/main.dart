// ignore_for_file: unused_import, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_declarations, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:it_schedule/Screens/home_screen.dart';
import 'package:it_schedule/Screens/user_screen.dart';
import 'package:it_schedule/admin/admin_panel.dart';
import 'package:it_schedule/page/auth_page.dart';
import 'package:it_schedule/widget/new_login_screen.dart';
import 'package:it_schedule/widget/new_signin_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:it_schedule/utils.dart';
import 'Splash_screen/splashScreen.dart';
import "model/database.dart";
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyAlkqhHQyMsS9GhitXTkYup33_fJuuVKEo',
          appId: '1:647916935531:web:c198a573c9b0019b9c142e',
          messagingSenderId: '647916935531',
          projectId: 'itschedule'));

  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static final String title = 'IT Schedule';

  @override
  /*Widget build(BuildContext context) => MaterialApp(
        scaffoldMessengerKey: Utils().messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: title,
        home: MainPage(),
      );*/
  Widget build(BuildContext context) => ChangeNotifierProvider(
        // create: (context) => EventProvider(),
        create: (BuildContext context) {},
        child: MaterialApp(
          scaffoldMessengerKey: Utils().messengerKey,
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: title,
          home: MainPage(),
        ),
      );
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong!'));
            } else if (snapshot.hasData && snapshot.data != null) {
              ClassHelper.saveUser(snapshot.data);
              return HomePage();
            } else {
              return 
                  splashScreen();
              
            }
          },
        ),
      );
}
