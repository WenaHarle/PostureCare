import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import '../gradient_utils.dart';

class DukunganLainPage extends StatelessWidget {
  // Method to launch WhatsApp
  void _launchWhatsApp() async {
    const phoneNumber = '+62 823-3669-4374';
    final Uri launchUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: phoneNumber,
    );
    await launchUrl(launchUri); // Use launchUrl to open WhatsApp
  }

  // Build a grid item
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dukungan Lain'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: buildGradient(), // Call the gradient function here
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: GridView.count(
            crossAxisCount: 4, // Keep 4 columns
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            shrinkWrap: true, // Make the grid take only the needed space
            physics: NeverScrollableScrollPhysics(), // Disable GridView scrolling
            children: [
              _buildGridItem(
                context,
                Icons.chat, // Chat icon for the button
                'Chat Bot', // Title for the button
                Colors.blue, // Color for the icon and circle
                _launchWhatsApp, // Function to call when tapped
              ),
              // Add more grid items here
              // _buildGridItem(
              //   context,
              //   Icons.home,
              //   'Home',
              //   Colors.green,
              //       () {
              //     // Add your action here
              //   },
              // ),
              // _buildGridItem(
              //   context,
              //   Icons.settings,
              //   'Settings',
              //   Colors.red,
              //       () {
              //     // Add your action here
              //   },
              // ),
              // Continue adding more items as needed
            ],
          ),
        ),
      ),
    );
  }
}
