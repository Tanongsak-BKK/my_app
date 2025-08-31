import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;
  List<Widget> screens = [
    const Center(child: Text('Home Page')),
    const Center(child: Text('Favorite Page')),
    const Center(child: Text('Settings Page')),
    const Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 147, 11, 215),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 227, 224),
        leading: Icon(Icons.menu, 
        size: 30.0, 
        color: Colors.black
        ),

        // This is the title of the app bar.
        title: Text(
          'My App',
          style: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.w700,
            color: Colors.deepPurpleAccent,
          ),
        ),


        actions: [
          IconButton(onPressed: (){
            print('Search Icon Pressed');
          }, icon: Icon(Icons.search,
          size: 30.0,
          color: Colors.black,
          
          ),
          ),

          SizedBox(width: 5.0,),

          IconButton(onPressed: (){}, icon: Icon(Icons.exit_to_app,
          size: 30.0, 
          color: const Color.fromARGB(255, 15, 15, 15),
          ),
          ),
        ],
      ),
      //body of the app
      body: screens[_selectedIndex],//screens[0]
        
        
      
      // This is the bottom navigation bar.
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 5, 228, 217),
        selectedItemColor: const Color.fromARGB(255, 1, 220, 8),
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,



        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 20.0,
        unselectedFontSize: 16.0,
        showUnselectedLabels: true,
        showSelectedLabels: true,


      ),
    );
  }
}
