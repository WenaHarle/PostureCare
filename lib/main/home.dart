import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/loginpage.dart';
import '../side/forum_diskusi_kesehatan.dart';
import '../side/informasi_tenaga_kesehatan.dart';
import '../side/dukungan_lain.dart';
import '../side/brace_management.dart';
import '../side/self_management.dart';
import '../side/edukasi_pasien.dart';
import '../side/setting.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.count(
                crossAxisCount: 4, // Keep 4 columns
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildGridItem(
                    context,
                    Icons.forum,
                    'Forum Diskusi Kesehatan',
                    Colors.cyan,
                        () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForumDiskusiKesehatanPage(),
                      ));
                    },
                  ),
                  _buildGridItem(
                    context,
                    Icons.info,
                    'Informasi Tenaga Kesehatan',
                    Colors.purple,
                        () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InformasiTenagaKesehatanPage(),
                      ));
                    },
                  ),
                  _buildGridItem(
                    context,
                    Icons.support,
                    'Dukungan Lain',
                    Colors.orange,
                        () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DukunganLainPage(),
                      ));
                    },
                  ),
                  _buildGridItem(
                    context,
                    Icons.manage_accounts,
                    'Brace Management',
                    Colors.red,
                        () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BraceManagementPage(),
                      ));
                    },
                  ),
                  _buildGridItem(
                    context,
                    Icons.self_improvement,
                    'Self Management',
                    Colors.brown,
                        () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SelfManagementPage(),
                      ));
                    },
                  ),
                  _buildGridItem(
                    context,
                    Icons.school,
                    'Edukasi Pasien',
                    Colors.teal,
                        () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EdukasiPasienPage(),
                      ));
                    },
                  ),
                  _buildGridItem(
                    context,
                    Icons.settings,
                    'Settings',
                    Colors.pink,
                        () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ));
                    },
                  ),
                  _buildGridItem(
                    context,
                    Icons.exit_to_app,
                    'Exit',
                    Colors.black,
                        () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(
      BuildContext context, IconData icon, String title, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(
                icon,
                size: 25.0,
                color: color,
              ),
              radius: 25.0,
            ),
            SizedBox(height: 8.0),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 10.0, // Reduced font size for better fit
                ),
                maxLines: 2, // Limit text to two lines
                overflow: TextOverflow.ellipsis, // Ellipsis if text overflows
              ),
            ),
          ],
        ),
      ),
    );
  }
}
