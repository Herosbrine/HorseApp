import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/home/home_page.dart';
import 'pages/start/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHG Racing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Segoe',
        primarySwatch: Colors.orange,
      ),
      home: const SplashScreen(),
    );
  }
}
