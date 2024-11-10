import 'package:flutter/material.dart';
import 'package:transport_app/Navbar.dart';
import 'package:transport_app/Screens/Community.dart';
import 'package:transport_app/Screens/Home.dart';
import 'package:transport_app/Screens/Login.dart';
import 'package:transport_app/Screens/Post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage()
    );
  }
}
