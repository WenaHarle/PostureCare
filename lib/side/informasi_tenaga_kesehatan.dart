import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';  // Import package url_launcher

class InformasiTenagaKesehatanPage extends StatelessWidget {
  final List<Map<String, String>> data = [
    {
      "nama": "dr. Muhammad Rezaalka Helto Sp.BS",
      "profesi": "Dokter Spesialis Bedah Syaraf",
      "testimoni": "Dr. Muhammad Rezaalka Helto Sp.BS merekomendasikan PostureCare sebagai solusi inovatif dan efektif untuk terapi kifosis postural pada anak-anak...",
      "link": "https://rezaalka.wordpress.com/",
      "image": "assets/logo.png",
    },
    {
      "nama": "dr. Rifky Mubarak SpKFR",
      "profesi": "Dokter Spesialis Rehabilitasi Medis",
      "testimoni": "Dalam perspektif seorang Dokter Spesialis Rehabilitasi Medis, PostureCare menawarkan solusi inovatif dan canggih...",
      "link": "https://herminahospitals.com/id/doctors/dr-rifky-mubarak-sp-fkr.html",
      "image": "assets/logo.png",
    },
    // Tambahkan data lainnya sesuai kebutuhan
  ];

  // Fungsi untuk membuka URL
  Future<void> _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        print('Could not launch $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Tenaga Kesehatan'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(item["image"]!), // Gambar dokter
                ),
                title: Text(
                  item["nama"]!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item["profesi"]!),
                    SizedBox(height: 4),
                    Text(item["testimoni"]!),
                    SizedBox(height: 4),
                    InkWell(
                      onTap: () {
                        _launchURL(item["link"]!); // Buka URL ketika di klik
                      },
                      child: Text(
                        "Baca lebih lanjut",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
