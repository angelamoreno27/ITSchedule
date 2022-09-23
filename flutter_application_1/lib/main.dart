import 'package:flutter/material.dart';
import 'Screens/HomePage.dart';
import 'Widgets/login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAlkqhHQyMsS9GhitXTkYup33_fJuuVKEo",
          appId: "1:647916935531:web:c198a573c9b0019b9c142e",
          messagingSenderId: "647916935531",
          projectId: "itschedule"));

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IT App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage());
  }
}
