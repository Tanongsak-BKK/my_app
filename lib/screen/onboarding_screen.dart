import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_app/screen/home_screen.dart';
import 'package:my_app/screen/login_screen.dart';
import 'package:my_app/screen/navbar_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final List<PageViewModel> pages = [
    PageViewModel(
      titleWidget: const SizedBox.shrink(), // ไม่ใช้ title ปกติ
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center, // จัดกลางจอ
        children: [
          // รูปเลื่อนลงมากลางจอ
          const SizedBox(height: 180),
          Image.asset("lib/images/logo.jpg", height: 300),
          const SizedBox(height: 20), // เว้นระยะ
          const Text(
            "Welcome to Hero Profile",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 254, 255, 255)),
          ),
          const SizedBox(height: 8),
          const Text(
            "Discover new places and plan your trips with ease.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
        ],
      ),
    ),

    PageViewModel(
      titleWidget: const SizedBox.shrink(), // ไม่ใช้ title ปกติ
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center, // จัดกลางจอ
        children: [
          // รูปเลื่อนลงมากลางจอ
          const SizedBox(height: 180),
          Image.asset("lib/images/v1.png", height: 300),
          const SizedBox(height: 20), // เว้นระยะ
          const Text(
            "point hiking",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 254, 255, 255)),
          ),
          const SizedBox(height: 8),
          const Text(
            "Hiking spots and mountains in Thailand.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),

    PageViewModel(
      titleWidget: const SizedBox.shrink(), // ไม่ใช้ title ปกติ
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center, // จัดกลางจอ
        children: [
          // รูปเลื่อนลงมากลางจอ
          const SizedBox(height: 180),
          Image.asset("lib/images/atk.gif", height: 300),
          const SizedBox(height: 20), // เว้นระยะ
          const Text(
            "Ready to pack your bags",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 255, 255, 255)),
          ),
          const SizedBox(height: 8),
          const Text(
            "Pack your bags and go into nature.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  ];

  Future<void> _finishOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    // ไปหน้า Login
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        /// 1) GIF พื้นหลัง (เต็มจอ)
        Image.asset(
          "lib/images/intomarvel.gif",  // ใส่ไฟล์ GIF ของคุณ
          fit: BoxFit.cover,
          gaplessPlayback: true, // ลดการกะพริบเวลาสลับเฟรม
        ),

        /// 2) เลเยอร์ไล่เฉด/ทับความมืด (แทน opacity เดิม)
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(103, 0, 0, 0),
                Color.fromARGB(255, 0, 0, 0),
              ],
              stops: [0.1, 0.4, 0.8],
            ),
          ),
        ),

        /// 3) เนื้อหา IntroductionScreen
        IntroductionScreen(
          globalBackgroundColor: const Color.fromARGB(0, 255, 255, 255), // โปร่งใส
          pages: pages,
          onDone: () => _finishOnboarding(context),
          showSkipButton: true,
          skip: const Text("Skip", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          next: const Icon(Icons.arrow_forward, color: Colors.white),
          done: const Text("Done", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          dotsDecorator: const DotsDecorator(
            color: Color.fromARGB(135, 0, 0, 0),
            size: Size(10, 10),
            activeSize: Size(15, 10),
            activeColor: Colors.white,
          ),
        ),
      ],
    ),
  );
}

}
