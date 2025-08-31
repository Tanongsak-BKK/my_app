import 'package:flutter/material.dart';
import 'package:my_app/screen/navbar_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30), // Slower rotation
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/images/spider-man.jpg', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 250), // Top spacing
                // Rotating circular photo in the center
                AnimatedBuilder(
                  animation: _controller,
                  child: CircleAvatar(
                    radius: 150,
                    backgroundImage: AssetImage('lib/images/spiderman-icon.jpg'),
                  ),
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: -_controller.value * 2 * 3.1415926535, // Negative for left rotation
                      child: child,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 250.0),
                  child: SizedBox(
                    width: 200, // Set button width
                    height: 60, // Set button height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Button background color
                        foregroundColor: Colors.red, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Rounded corners
                        ),
                        elevation: 8, // Shadow
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NavbarScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'HISTORY',
                        style: TextStyle(
                          fontSize: 24, // Font size
                          fontWeight: FontWeight.bold, // Font weight
                          color: Colors.red, // Text color
                          fontFamily: 'Roboto', // Change to your desired font family
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
