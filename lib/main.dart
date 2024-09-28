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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // path to your logo asset
              height: 40.0, // adjust as needed
            ),
            SizedBox(width: 8.0),
            Text('Posture Care',
            style: GoogleFonts.poppins()
            ),
          ],
        ),
        backgroundColor: Colors.grey.shade300,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey.shade300,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
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
      body: _pages[_pageIndex],
    );
  }
}
