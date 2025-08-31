import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_app/screen/home_screen.dart';
import 'package:my_app/screen/welcome_screen.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _selectedIndex = 0;

  final _page = [
    WelcomeScreen(),
    HomeScreen(),
    Center(child: Text("search screen")),
    Center(child: Text("profile screen")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_selectedIndex],

      //curved_navbar
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        color: Color.fromARGB(255, 0, 255, 187),
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInQuad,
        height: 60.0,
        buttonBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        items: [
          Icon(Icons.home, size: 30, ),
          Icon(Icons.notifications, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index ;
          });
        },
      ),
    );
  }
}
