import 'package:flutter/material.dart';
import 'package:my_app/screen/login_screen.dart';
import 'package:my_app/screen/navbar_screen.dart';

import 'package:my_app/screen/onboarding_screen.dart';
import 'package:my_app/screen/welcome_screen.dart';

import 'package:device_preview/device_preview.dart';



void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color.fromARGB(255, 19, 220, 238),
      debugShowCheckedModeBanner: false,
      title: 'Flutter demo app.',
      home: OnboardingScreen(),  
    );
  }
}