import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:posturecare/auth/loginpage.dart';
import 'main/profile.dart';
import 'side/forum_diskusi_kesehatan.dart';
import 'side/informasi_tenaga_kesehatan.dart';
import 'side/dukungan_lain.dart';
import 'side/brace_management.dart';
import 'side/self_management.dart';
import 'side/edukasi_pasien.dart';
import 'side/faq.dart';
import 'side/setting.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String _accountName = 'Posture Care';
  String _accountEmail = 'example@gmail.com';
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

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users') // Replace with your collection name
          .doc(user.uid)
          .get();

      // Check if the document exists and has data
      if (userDoc.exists && userDoc.data() != null) {
        // Extract user data
        setState(() {
          _accountName = userDoc.get('fullName') ?? 'Posture Care';
          _accountEmail = userDoc.get('email') ?? 'example@gmail.com';

          // Check if user has a profile picture URL, else use default profile image
          String? profileImageUrl = userDoc.get('profileImageUrl');
          if (profileImageUrl != null && profileImageUrl.isNotEmpty) {
            _currentAccountPicture = NetworkImage(profileImageUrl);
          } else {
            _currentAccountPicture = AssetImage('assets/profile.png'); // Default profile image
          }

          _isLoading = false;
        });
      } else {
        // Handle case where document doesn't exist or has no data
        setState(() {
          _isLoading = false;
        });
        print('Document does not exist or has no data');
      }
    } catch (e) {
      // Handle errors
      print('Error fetching user data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(_isLoading ? 'Loading...' : _accountName),
            accountEmail: Text(_isLoading ? 'Loading...' : _accountEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: _currentAccountPicture,
            ),
            decoration: BoxDecoration(
              color: Colors.orange,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg',
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profil Pasien'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ));
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.medical_services),
            title: Text('Profil Tenaga Kesehatan'),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.forum),
                title: Text('Forum Diskusi Kesehatan'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForumDiskusiKesehatanPage(),
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Informasi Tenaga Kesehatan'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => InformasiTenagaKesehatanPage(),
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.support),
                title: Text('Dukungan Lain'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DukunganLainPage(),
                  ));
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Brace Management'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BraceManagementPage(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.self_improvement),
            title: Text('Self Management'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SelfManagementPage(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Edukasi Pasien'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EdukasiPasienPage(),
              ));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('FAQ'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FAQPage(),
              ));
            },
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: ()  {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
