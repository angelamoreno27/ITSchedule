import 'package:flutter/material.dart';
import 'package:it_schedule/Screens/class_hours_screen.dart';
import 'package:it_schedule/Screens/home_screen.dart';
import 'package:it_schedule/page/auth_page.dart';
import 'package:it_schedule/provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:it_schedule/widget/login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:it_schedule/utils.dart';
import 'package:intl/intl.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyCj3zKui1YZ-h-v0zLckCMTpY0NqA4q17g',
          appId: '1:451138854975:web:e2ec7f6c01f096b789588a',
          messagingSenderId: '451138854975',
          projectId: 'it-schedule'));

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
        create: (context) => EventProvider(),
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
            } else if (snapshot.hasData) {
              return HomePage();
            } else {
              return AuthPage();
            }
          },
        ),
      );
}
