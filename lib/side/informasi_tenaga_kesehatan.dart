import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';  // Import package url_launcher
import '../gradient_utils.dart';

class InformasiTenagaKesehatanPage extends StatelessWidget {
  final List<Map<String, String>> data = [
    {
      "nama": "dr. Muhammad Rezaalka Helto Sp.BS",
      "profesi": "Dokter Spesialis Bedah Syaraf",
      "link": "https://rezaalka.wordpress.com/",
      "image": "assets/dokter/helto.png",
      "profilPenuh": "Dr. Muhammad Rezaalka Helto, Sp.BS, merekomendasikan PostureCare sebagai solusi inovatif dan efektif untuk terapi kifosis postural pada anak-anak. Sebagai Dokter Spesialis Bedah Saraf, saya memahami bahwa permasalahan tulang belakang seperti kifosis dapat menyebabkan nyeri, gangguan mobilitas, dan kerusakan pada organ vital jika tidak ditangani dengan baik. PostureCare, dengan sistem monitoring dan deteksi kesalahan ergonomis berbasis Internet of Things (IoT), menawarkan pendekatan canggih untuk memantau dan mengoreksi postur anak-anak secara real-time. Alat ini dilengkapi dengan sensor gyroscope untuk mendeteksi kesalahan posisi, modul vibration dan LED sebagai pengingat, serta polymade heater untuk terapi panas yang membantu mengurangi nyeri dan memperbaiki sirkulasi darah. Dengan aplikasi yang terhubung ke IoT, data perubahan postur dapat dipantau secara harian, memberikan pemahaman yang lebih baik tentang efektivitas terapi. Inovasi ini tidak hanya memberikan dukungan pada lumbal dan mengoreksi deviasi postural, tetapi juga memudahkan terapis dan orang tua dalam memantau kemajuan terapi anak-anak mereka, menjadikan PostureCare sebagai solusi ideal dalam menghadapi tantangan kesehatan tulang belakang pasca pandemi."
    },
    {
      "nama": "dr. Rifky Mubarak SpKFR",
      "profesi": "Dokter Spesialis Rehabilitasi Medis",
      "link": "https://herminahospitals.com/id/doctors/dr-rifky-mubarak-sp-fkr.html",
      "image": "assets/dokter/mubarak.png",
      "profilPenuh": 'Dalam perspektif seorang Dokter Spesialis Rehabilitasi Medis, produk \"Posture Care\" menawarkan solusi inovatif dan canggih untuk mengatasi masalah kifosis postural pada anak-anak, terutama di masa transisi endemi COVID-19 yang telah memicu peningkatan kelainan tulang belakang akibat perubahan pola hidup. Posture Care, yang menggabungkan teknologi Internet of Things (IoT), mampu memonitor dan mendeteksi kesalahan postur secara real-time, memberikan umpan balik korektif melalui modul getar dan LED, serta mendukung terapi dengan thermotherapy melalui heater polymade yang meningkatkan sirkulasi darah dan mengurangi nyeri. Dengan adanya aplikasi yang terhubung, terapis dan orang tua dapat secara efektif mengawasi dan mengevaluasi progres terapi, memastikan intervensi yang tepat waktu dan personalisasi perawatan. Inovasi ini tidak hanya memperkaya pendekatan rehabilitasi medis, tetapi juga meningkatkan kualitas hidup anak dengan kifosis, mengurangi risiko komplikasi jangka panjang, dan mempromosikan postur yang sehat sejak dini.'
    },
    {
      "nama": "dr. Mukharradhi Nanza, M.Ked(Surg), Sp.OT ",
      "profesi": "Spesialis Orthopedi Anak",
      "link": "https://repositori.usu.ac.id/handle/123456789/66/browse?type=author&value=Nanza%2C+Mukharradhi",
      "image": "assets/dokter/nazan.png",
      "profilPenuh": 'Saya menyarankan penggunaan "PostureCare" sebagai solusi inovatif untuk terapi kifosis postural pada anak-anak, terutama dalam menghadapi transisi endemi COVID-19. Dalam perspektif teoretis seorang Dokter Spesialis Orthopedi Anak, "PostureCare" menawarkan pendekatan canggih yang terintegrasi dengan teknologi Internet of Things (IoT) untuk memantau dan mengoreksi postur tulang belakang secara real-time. Alat ini menggunakan sensor gyroscope dan mikrokontroler ESP32 untuk mendeteksi kesalahan ergonomis dan memberikan umpan balik langsung melalui modul vibration dan lampu LED. Selain itu, fungsi thermotherapy dari polymade heater membantu mengurangi nyeri dan meningkatkan sirkulasi darah di area yang terdampak. Aplikasi pendukungnya memungkinkan monitoring harian dan evaluasi efektivitas terapi, memberikan pemahaman yang lebih baik tentang perkembangan postur anak. Dengan demikian, "PostureCare" tidak hanya mengoptimalkan terapi kifosis, tetapi juga meminimalkan risiko komplikasi jangka panjang, menjadikannya alat penting dalam penanganan kelainan tulang belakang pada anak-anak dalam era pasca-pandemi.'
    },
    {
      "nama": "Ns. Endah Panca Lydia Fatma, S.Kep., M.Kep, Sp.Kep.MB",
      "profesi": "Spesialis Keperawatan Medikal Bedah",
      "link": "https://scholar.google.com/citations?user=5nNpjo4AAAAJ&hl=en&oi=ao",
      "image": "assets/dokter/endah.png",
      "profilPenuh": 'Ns. Endah Panca Lydia Fatma, S.Kep., M.Kep., Sp.Kep.MB, menekankan pentingnya teknologi ini dalam mendukung peran perawat medikal bedah yang bertanggung jawab terhadap pencegahan, penilaian, dan intervensi kelainan tulang belakang. PostureCare tidak hanya memonitor deviasi dan rotasi lateral tulang belakang melalui sensor gyroscope, tetapi juga menggunakan modul vibration dan LED sebagai pengingat korektif serta polymade heater untuk thermotherapy, yang secara signifikan mengurangi nyeri dan memperbaiki sirkulasi darah. Dalam konteks keperawatan medikal bedah, alat ini memfasilitasi pengawasan berkelanjutan dan penyesuaian terapi berdasarkan data real-time, sehingga perawat dapat melakukan intervensi yang lebih tepat dan cepat dalam menangani kifosis. Dengan kemampuan untuk terhubung ke aplikasi yang menampilkan grafik perubahan sudut tulang belakang harian, PostureCare menyediakan alat komprehensif bagi terapis dan orang tua untuk memantau dan menilai efektivitas terapi secara efisien, menjadikan pengelolaan kifosis pada anak lebih terarah dan efektif dalam jangka panjang.'
    },
    {
      "nama": "Ns. Rustiana Tasya Ariningpraja, S.Kep, M.Biomed, Sp.Kep.MB ",
      "profesi": "Spesialis Keperawatan Medikal Bedah",
      "link": "https://scholar.google.com/citations?user=5nNpjo4AAAAJ&hl=en&oi=ao",
      "image": "assets/dokter/Rustiana.png",
      "profilPenuh": 'Saya sangat mengapresiasi nilai tambah PostureCare dalam memfasilitasi peran perawat dalam memberikan asuhan yang holistik dan berbasis bukti. Alat ini tidak hanya membantu dalam memantau perkembangan postur tulang belakang secara real-time, tetapi juga memberikan kemungkinan untuk penyesuaian terapi yang cepat berdasarkan data yang terkumpul. Selain itu, dengan fitur notifikasi dan pengingat yang terhubung ke aplikasi, PostureCare memungkinkan perawat untuk melakukan intervensi yang lebih tepat waktu dan efektif. Dengan demikian, alat ini tidak hanya memberikan dukungan dalam peningkatan kualitas asuhan keperawatan medikal bedah, tetapi juga mengoptimalkan peran perawat dalam memastikan pasien mendapatkan perawatan yang sesuai dengan kebutuhan mereka, menjadikan pengelolaan kifosis pada anak lebih efisien dan efektif dalam konteks keperawatan medikal bedah yang berkelanjutan.'
    },
    {
      "nama": "Alfrina Hany, S.Kp, M.Ng(Acute Care)",
      "profesi": "Spesialis Keperawatan Medikal Bedah (Acute Care)",
      "link": "https://sinta.kemdikbud.go.id/authors/profile/6017590/?view=iprs",
      "image": "assets/dokter/alfina.png",
      "profilPenuh": 'Dengan fitur-fitur seperti sensor gyroscope untuk mendeteksi kesalahan posisi tulang belakang dan modul vibration serta polymade heater untuk terapi tambahan, PostureCare tidak hanya membantu dalam merencanakan dan melaksanakan perawatan yang lebih efisien, tetapi juga memungkinkan perawat seperti saya dengan focus acute care untuk memberikan perawatan yang lebih personal dan terarah kepada setiap pasien. Penggunaan teknologi ini membuka jalan bagi perawatan acute care seperti nyeri dan beragam hal yang lebih holistik dan inovatif dalam manajemen kelainan tulang belakang, menggabungkan aspek klinis dengan teknologi modern untuk hasil yang lebih baik bagi pasien'
    },
    {
      "nama": "Ns. Elvira Sari Dewi, S.Kep, M.Biomed",
      "profesi": "Spesialisasi Bidang Biomedik (Thermotheraphy)",
      "link": "https://scholar.google.com/citations?user=Kibmt18AAAAJ&hl=en&oi=ao",
      "image": "assets/dokter/elvitra.png",
      "profilPenuh": 'Sebagai seorang ahli dalam bidang Biomedik dengan spesialisasi dalam Thermotherapy, saya sangat terkesan dengan efektivitas produk "PostureCare". Melalui pendekatan terbaru berbasis Internet of Things (IoT), alat ini tidak hanya mampu memonitor dan mengoreksi postur tulang belakang secara real-time, tetapi juga mengintegrasikan penggunaan polymade heater untuk thermotherapy. Penggunaan suhu yang terkontrol dengan tepat (40°C-45°C) pada area yang terkena kifosis membawa manfaat yang signifikan dalam mengurangi nyeri dan meningkatkan sirkulasi darah. Sebagai seorang yang berfokus pada penelitian dan pengembangan teknologi kesehatan, saya melihat bahwa "PostureCare" memberikan solusi komprehensif dalam penanganan kelainan tulang belakang, sesuai dengan prinsip-prinsip dasar Thermotherapy yang berfokus pada penggunaan panas untuk memperbaiki kesehatan jaringan dan meminimalkan gejala yang berkaitan dengan kondisi patologis. Dengan kombinasi teknologi canggih dan konsep dasar teoritis yang kuat, saya yakin produk ini akan menjadi tonggak penting dalam perawatan kifosis pada anak-anak serta meningkatkan kualitas hidup mereka secara keseluruhan.'
    },
    {
      "nama": "Dr. Ns. Heni Dwi Windarwati, S.Kep, M.Kep, Sp.Kep.J ",
      "profesi": "Spesialis Keperawatan Jiwa",
      "link": "https://scholar.google.com/citations?user=rpU6-0IAAAAJ&hl=en&oi=ao",
      "image": "assets/dokter/heni.png",
      "profilPenuh": 'Dengan adanya terapi PostureCare, saya sebagai seorang Spesialis Keperawatan Jiwa, Dr. Ns. Heni Dwi Windarwati, S.Kep, M.Kep, Sp.Kep.J, melihat bahwa alat ini tidak hanya memiliki manfaat fisik tetapi juga mempengaruhi kesejahteraan mental anak-anak yang mengalami kifosis. Teori dasar yang saya perhatikan adalah teori self-concept, dimana penampilan fisik yang buruk dapat mempengaruhi persepsi diri individu. Dengan bantuan PostureCare, anak-anak dapat memperbaiki postur tubuh mereka secara mandiri, meningkatkan rasa percaya diri, dan mengurangi stigma sosial yang mungkin mereka rasakan. Melalui teknologi ini, mereka dapat merasa lebih baik tentang diri mereka sendiri, membantu dalam proses penyembuhan secara keseluruhan dengan layanan konsultasi psikologis.'
    },
    {
      "nama": "Dr. Ns. Rinik Eko Kapti, S.Kep, M.Kep ",
      "profesi": "Spesialis Keperawatan Anak dan Keperawatan Kronis",
      "link": "https://scholar.google.com/citations?user=Xhyh8FkAAAAJ&hl=en&oi=ao",
      "image": "assets/dokter/rinik.png",
      "profilPenuh": 'Dalam praktiknya sebagai seorang Spesialis Keperawatan Anak dan Keperawatan Kronis, saya telah menyaksikan bagaimana PostureCare memberikan dampak positif yang signifikan dalam penanganan kifosis pada anak-anak. Konsep terapi kifosis postural berbasis Internet of Things (IoT) yang diusung oleh PostureCare sangat relevan dengan teori yang menekankan pentingnya intervensi dini dan pemantauan kontinu dalam pengelolaan kelainan tulang belakang. Melalui sensor gyroscope yang sensitif dan modul komunikasi IoT, PostureCare memberikan pemahaman yang lebih baik tentang perbaikan postur serta memungkinkan intervensi yang tepat waktu. Sebagai seorang perawat anak dan kronis, saya percaya bahwa teknologi ini tidak hanya mengoptimalkan perawatan kifosis, tetapi juga meningkatkan kualitas hidup pasien secara menyeluruh, sesuai dengan prinsip-prinsip dasar keperawatan anak dan kronis yang saya anut.'
    },
    {
      "nama": "Inggita Kusumastuty, S.Gz, M.Biomed",
      "profesi": "Konsultan Gizi Klinik Kesehatan",
      "link": "https://scholar.google.com/citations?user=hXtXPGoAAAAJ&hl=en&oi=ao",
      "image": "assets/dokter/inggita.png",
      "profilPenuh": 'Dalam perjalanan karier saya sebagai Konsultan Gizi Klinik Kesehatan, saya telah melihat begitu banyak kasus di mana pola makan yang tidak sehat berkontribusi pada masalah kesehatan tulang belakang, termasuk kifosis pada anak. Melalui penggunaan PostureCare, saya dapat melihat dampak positifnya secara langsung. Alat ini tidak hanya memberikan pendekatan revolusioner dalam memantau dan mendukung terapi kifosis, tetapi juga memberikan pemahaman yang lebih baik tentang perbaikan postur melalui aplikasi berbasis IoT. Dengan pemantauan yang lebih akurat dan terapi yang disesuaikan, saya yakin kami dapat memberikan perawatan yang lebih efektif dan berkelanjutan bagi pasien kami. PostureCare bukan hanya alat, tetapi juga merupakan langkah maju dalam bidang kesehatan tulang belakang, dan saya sangat bersemangat untuk terus mengintegrasikannya dalam praktik klinis saya.'
    },
    {
      "nama": "Ns. Ike Nesdia Rahmawati, S.Kep., M.Kep",
      "profesi": "Spesialisasi Manajemen Keperawatan – Keselamatan Pasien",
      "link": "https://scholar.google.com/citations?user=XUzn0A0AAAAJ&hl=en&oi=ao",
      "image": "assets/dokter/ike.png",
      "profilPenuh": 'Sebagai seorang yang berfokus pada manajemen keperawatan dengan spesialisasi dalam keselamatan pasien, saya sangat terkesan dengan kontribusi yang ditawarkan oleh "PostureCare" dalam konteks pencegahan dan penanganan kelainan tulang belakang pada anak-anak. Dengan teknologi yang terintegrasi dengan Internet of Things (IoT), alat ini tidak hanya memungkinkan pemantauan real-time terhadap postur tulang belakang, tetapi juga memberikan pengingat dan intervensi yang tepat waktu melalui modul vibration dan LED. Melalui pendekatan yang holistik, PostureCare membantu meningkatkan pemahaman tentang perbaikan postur dan efektivitas terapi, sehingga memungkinkan perawat untuk merencanakan dan mengimplementasikan strategi perawatan yang lebih terarah dan efisien. Dengan demikian, alat ini tidak hanya menjadi alat bantu klinis, tetapi juga merupakan instrumen penting dalam upaya mewujudkan keselamatan pasien secara menyeluruh.'
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: buildGradient(), // Call the gradient function here
          ),
        ),
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
                    SizedBox(height: 8),
                    InkWell(
                          onTap: () {
                    _launchURL(item["link"]!); // Buka URL ketika di klik
                    },
                      child: Text(
                        "Profil",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to full profile page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilPenuhPage(
                              nama: item["nama"]!,
                              profesi: item["profesi"]!,
                              profilPenuh: item["profilPenuh"]!,
                              image: item["image"]!,
                            ),
                          ),
                        );
                      },

                      child: Text("Testimoni"),
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

// Halaman Profil Penuh dengan fitur scroll
class ProfilPenuhPage extends StatelessWidget {
  final String nama;
  final String profesi;
  final String profilPenuh;
  final String image;

  ProfilPenuhPage({
    required this.nama,
    required this.profesi,
    required this.profilPenuh,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testimoni'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: buildGradient(), // Call the gradient function here
          ),
        ),
      ),
      body: SingleChildScrollView(  // Enable scrolling for content
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(image),
            ),
            SizedBox(height: 16),
            Text(
              nama,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              profesi,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              profilPenuh,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
