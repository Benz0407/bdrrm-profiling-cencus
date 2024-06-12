import 'package:flutter/material.dart';
import 'package:mobile/screens/main_screen.dart';
import 'package:mobile/const/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashborad UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const MainScreen(),
    );
  }
}
