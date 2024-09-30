import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash.dart';
import 'main/graph_page.dart';
import 'main/profile.dart';
import 'main/heater_page.dart';
import 'firebase_options.dart';
import 'main/home.dart';
import 'side/faq.dart';
import 'package:google_fonts/google_fonts.dart';
import 'gradient_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  final List<Widget> _pages = [
    MainPage(),
    GraphPage(),
    HeaterControlPage(),
    FAQPage(),
    ProfilePage(),
  ];

  // Method to create a gradient

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo2.png', // path to your logo asset
              height: 40.0, // adjust as needed
            ),
            SizedBox(width: 20.0),
            Text(
              'PostureCare',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white, // White text on gradient
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: buildGradient(), // Gradient for AppBar
              ),
            ),
            Positioned(
              left: -20,
              top: 40,
              bottom: 5,
              child: Container(
                width: 80, // Adjust the width to your needs
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100), // Smaller radius for rounded rectangle
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.message, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bar.png'), // Use the uploaded image as background
            fit: BoxFit.cover, // Ensure the image covers the entire background
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent, // Ensure the background is transparent
          elevation: 0, // Remove any shadow or elevation effect
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.white, // White for unselected icons
          onTap: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              label: 'Graph',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.thermostat),
              label: 'Heater',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: 'FAQ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: _pages[_pageIndex],
    );
  }
}
