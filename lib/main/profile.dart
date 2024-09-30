import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/loginpage.dart';
import '../side/setting.dart';
import '../main/progress.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _accountName = ' ';
  String _accountEmail = ' ';
  ImageProvider<Object>? _currentAccountPicture = AssetImage('assets/profile.png');
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        setState(() {
          _accountName = userDoc.get('fullName') ?? ' ';
          _accountEmail = userDoc.get('email') ?? ' ';

          String? profileImageUrl = userDoc.get('profileImageUrl');
          if (profileImageUrl != null && profileImageUrl.isNotEmpty) {
            _currentAccountPicture = NetworkImage(profileImageUrl);
          } else {
            _currentAccountPicture = AssetImage('assets/profile.png');
          }

          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        print('Document does not exist or has no data');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundImage: _currentAccountPicture,
          ),
          SizedBox(height: 8.0),
          Text(
            _accountName,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _accountEmail,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: GoogleFonts.poppins(),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            _buildProfileHeader(),
            _isLoading
                ? CircularProgressIndicator()
                : Container(
                    margin: EdgeInsets.all(16.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildProfileOption(Icons.info, 'About PostureCare', () {
                          // Handle About PostureCare action
                        }),
                        Divider(),
                        _buildProfileOption(Icons.history, 'History', () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WeeklyProgressPage(),
                          ));
                        }),
                        Divider(),
                        _buildProfileOption(Icons.settings, 'Settings', () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ));
                        }),
                        Divider(),
                        _buildProfileOption(Icons.logout, 'Logout', () {
                          // Handle Logout action
                          FirebaseAuth.instance.signOut().then((value) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false,
                            );
                          });
                        }),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
