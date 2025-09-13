import 'package:flutter/material.dart';

import 'package:my_app/screen/collection_screen.dart';
import 'package:my_app/screen/history_screen.dart';
import 'package:my_app/screen/home_screen.dart';
import 'package:my_app/screen/profile_screen.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    HistoryScreen(),
    CollectionScreen(),
    ProfileScreen(),
  ];

  static const Color activeIcon = Colors.white;
  static const Color inactiveIcon = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),

      // ทำให้ navbar คลุมเต็มด้านล่าง
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0), // ดำเต็มแถบ
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: activeIcon,
        unselectedItemColor: inactiveIcon,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: _selectedIndex == 0 ? 30 : 26,
              color: _selectedIndex == 0 ? activeIcon : inactiveIcon,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: _selectedIndex == 1 ? 30 : 26,
              color: _selectedIndex == 1 ? activeIcon : inactiveIcon,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
              size: _selectedIndex == 2 ? 30 : 26,
              color: _selectedIndex == 2 ? activeIcon : inactiveIcon,
            ),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_accessibility,
              size: _selectedIndex == 3 ? 30 : 26,
              color: _selectedIndex == 3 ? activeIcon : inactiveIcon,
            ),
            label: 'Shield',
          ),
        ],
      ),
    );
  }
}
