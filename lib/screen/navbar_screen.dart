import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:my_app/screen/collection_screen.dart';
import 'package:my_app/screen/history_screen.dart';
import 'package:my_app/screen/home_screen.dart';
import 'package:my_app/screen/profile_screen.dart';
import 'package:my_app/screen/welcome_screen.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _selectedIndex = 0;

  // ใช้ IndexedStack เพื่อคง state ของแต่ละหน้า
  final List<Widget> _pages = const [
    HistoryScreen(),
    HomeScreen(),
    CollectionScreen(),
    ProfileScreen(),
  ];

  // สีหลักที่ใช้ ซ่อม/ปรับได้ง่าย
  static const Color barColor = Color.fromARGB(255, 102, 3, 3); // สีแถบ
  static const Color bubbleColor = Color.fromARGB(255, 0, 0, 0);   // สีปุ่มลอย
  static const Color activeIcon = Color.fromARGB(255, 255, 255, 255);    // สีไอคอนเมื่อเลือก
  static const Color inactiveIcon = Color.fromARGB(255, 255, 255, 255);   // สีไอคอนปกติ

  List<Widget> _navItems() {
    final icons = [
      Icons.assignment_ind,
      Icons.contact_emergency,
      Icons.collections,
      Icons.person,
    ];
    return List.generate(icons.length, (i) {
      final isActive = i == _selectedIndex;
      return Icon(
        icons[i],
        size: 26,
        color: isActive ? activeIcon : const Color.fromARGB(255, 255, 255, 255),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // ให้พื้นหลังของ curved bar ซ้อนบน body ได้เนียนขึ้น
      body: IndexedStack(index: _selectedIndex, children: _pages),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 0),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color.fromARGB(255, 116, 20, 13), // Red border
              width: 3,          // Border thickness
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: CurvedNavigationBar(
            index: _selectedIndex,
            items: _navItems(),                 // ใช้ไอคอนที่ปรับสีตามสถานะ
            height: 56,
            backgroundColor: Colors.transparent, // โปร่งใสเพื่อเห็นกล่อง/เงา
            color: barColor,                     // สีแถบหลัก (โค้ง)
            buttonBackgroundColor: bubbleColor,  // สีปุ่มลอย
            animationDuration: const Duration(milliseconds: 320),
            animationCurve: Curves.easeOutCubic,
            onTap: (index) => setState(() => _selectedIndex = index),
          ),
        ),
      ),
    );
  }
}
