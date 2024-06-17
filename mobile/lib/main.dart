import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile/model/user_model.dart';
import 'package:mobile/screens/landing_screen.dart';
import 'package:mobile/const/constant.dart';
import 'package:mobile/services/login_service.dart';
import 'package:mobile/services/register_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginService()),
        ChangeNotifierProvider(create: (_) => RegisterService()),
        // Add other providers here if necessary
      ],
      child: const MyApp(),
    ),
  );
}
class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final User user = User(); 
    return MaterialApp(
      title: 'Dashborad UI',
      debugShowCheckedModeBanner: false,
      scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
      ),
      // home: const MainScreen(),
      home: const LandingScreen(),
    );
  }
}
