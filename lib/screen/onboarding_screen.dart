import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final List<PageViewModel> page = [
    PageViewModel(
      title: "Welcome to MyApp",
      body: "This is a simple onboarding screen example.",
      image: Center(child: Image.asset("assets/images/", height: 175.0)),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 16.0),
      ),
    ),
    // Add more PageViewModel instances here for additional onboarding pages
    PageViewModel(
      title: "Get Started",
      body: "Let's get started using MyApp!",
      image: Center(child: Image.asset("assets/images/", height: 175.0)),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 16.0),
      ),
    ),
    PageViewModel(
      title: "back to MyApp",
      body: "Let's get started using MyApp!",
      image: Center(child: Image.asset("assets/images/", height: 175.0)),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 16.0),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: page,
        onDone: ()  {
          
        },
        curve: Curves.bounceOut,
        dotsDecorator: DotsDecorator(
          color: Colors.grey,
          activeColor: Colors.blue,
          size:  Size(10.0, 10.0),
          activeSize:  Size(22.0, 10.0),
          spacing:  EdgeInsets.symmetric(horizontal: 3.0),
        ),
        showSkipButton: true,
        skip: Text("Skip"),

        
        showNextButton: true,
        next: const Icon(Icons.arrow_forward),
      
        showDoneButton: true,
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        
      
      ),
      // You can add onDone, onSkip, showSkipButton, etc. as needed

    );
  }
}