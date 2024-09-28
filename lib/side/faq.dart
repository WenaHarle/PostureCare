import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final List<Map<String, dynamic>> faqs = [
    {'question': 'Apa itu kifosis?', 'answer': 'Kifosis adalah kelainan pada tulang belakang yang menyebabkan punggung atas melengkung ke depan, sehingga punggung tampak bungkuk.'},
    {'question': 'Apa gejala utama kifosis pada anak?', 'answer': 'Gejala utama termasuk postur tubuh yang bungkuk, sakit punggung, kekakuan pada tulang belakang, dan dalam beberapa kasus, kesulitan bernapas.'},
    {'question': 'Apa penyebab kifosis pada anak?', 'answer': 'Penyebab dapat bervariasi, termasuk postur tubuh yang buruk, kondisi medis seperti penyakit Scheuermann, trauma atau cedera tulang belakang, dan penyakit degeneratif.'},
    {'question': 'Bagaimana cara mendiagnosis kifosis?', 'answer': 'Diagnosis dilakukan melalui pemeriksaan fisik oleh dokter, dan seringkali disertai dengan pemeriksaan pencitraan seperti rontgen untuk melihat derajat kelengkungan tulang belakang.'},
    {'question': 'Apakah kifosis dapat menyebabkan nyeri?', 'answer': 'Ya, kifosis dapat menyebabkan nyeri punggung, terutama jika lengkungan cukup parah atau jika ada tekanan pada saraf.'},
    {'question': 'Kapan sebaiknya membawa anak ke fasilitas kesehatan?', 'answer': 'Segera bawa anak ke fasilitas kesehatan jika terlihat tanda-tanda kifosis, terutama jika disertai nyeri, kekakuan yang parah, atau kesulitan bernapas.'},
    {'question': 'Bagaimana penatalaksanaan awal untuk kifosis pada anak?', 'answer': 'Penatalaksanaan awal meliputi observasi, terapi fisik untuk memperkuat otot punggung, dan latihan postur tubuh yang baik.'},
    {'question': 'Apa itu brace dan bagaimana penggunaannya untuk kifosis?', 'answer': 'Brace adalah alat penyangga yang dikenakan di luar tubuh untuk membantu mengoreksi postur tubuh dan mencegah kelengkungan bertambah parah.'},
    {'question': 'Seberapa sering anak harus memakai brace?', 'answer': 'Penggunaan brace biasanya disarankan sepanjang hari, kecuali saat mandi atau aktivitas tertentu, namun jadwal spesifik harus mengikuti saran dokter.'},
    {'question': 'Apakah penggunaan brace menyakitkan?', 'answer': 'Brace mungkin menyebabkan ketidaknyamanan pada awalnya, namun seharusnya tidak menyebabkan nyeri. Jika terasa nyeri, konsultasikan dengan dokter.'},
    {'question': 'Apa itu terapi panas (thermotherapy) dan bagaimana membantu kifosis?', 'answer': 'Terapi panas melibatkan penggunaan panas untuk mengurangi nyeri dan kekakuan otot. Ini bisa berupa kompres panas atau mandi air hangat.'},
    {'question': 'Bagaimana cara melakukan terapi fisik untuk kifosis?', 'answer': 'Terapi fisik biasanya melibatkan latihan peregangan dan penguatan otot punggung, yang dipandu oleh ahli terapi fisik.'},
    {'question': 'Apakah operasi diperlukan untuk kifosis?', 'answer': 'Operasi biasanya hanya diperlukan pada kasus kifosis yang sangat parah atau jika metode lain tidak berhasil mengurangi gejala.'},
    {'question': 'Apakah kifosis bisa sembuh total?', 'answer': 'Penyembuhan total bergantung pada penyebab dan keparahan kifosis. Banyak kasus dapat dikelola dengan baik melalui terapi konservatif.'},
    {'question': 'Apakah anak dengan kifosis bisa berolahraga?', 'answer': 'Ya, tetapi sebaiknya berkonsultasi dengan dokter atau terapis fisik untuk memilih jenis olahraga yang aman dan bermanfaat.'},
    {'question': 'Apa peran keluarga dalam penanganan kifosis?', 'answer': 'Keluarga harus mendukung anak dalam menjalani terapi, penggunaan brace, dan menjaga postur tubuh yang baik.'},
    {'question': 'Bagaimana cara mendukung anak secara emosional dengan kifosis?', 'answer': 'Berikan dukungan emosional, dorongan, dan pengertian. Ajak anak berbicara tentang perasaannya dan jaga kepercayaan dirinya.'},
    {'question': 'Apakah ada diet khusus untuk anak dengan kifosis?', 'answer': 'Tidak ada diet khusus, tetapi diet seimbang yang kaya kalsium dan vitamin D dapat membantu menjaga kesehatan tulang.'},
    {'question': 'Apakah kifosis mempengaruhi pertumbuhan anak?', 'answer': 'Kifosis yang parah bisa mempengaruhi tinggi badan dan postur tubuh, tetapi tidak selalu mempengaruhi pertumbuhan secara keseluruhan.'},
    {'question': 'Bagaimana cara memperbaiki postur tubuh anak dengan kifosis?', 'answer': 'Latihan postur tubuh, penggunaan brace, dan terapi fisik dapat membantu memperbaiki postur tubuh.'},
    {'question': 'Apakah kifosis genetik?', 'answer': 'Beberapa bentuk kifosis dapat memiliki komponen genetik, tetapi tidak selalu.'},
    {'question': 'Bisakah anak dengan kifosis pergi ke sekolah normal?', 'answer': 'Ya, anak dengan kifosis biasanya dapat mengikuti sekolah normal, tetapi mungkin perlu penyesuaian tertentu seperti kursi yang ergonomis.'},
    {'question': 'Apa saja komplikasi yang bisa terjadi akibat kifosis?', 'answer': 'Komplikasi bisa termasuk nyeri kronis, masalah pernapasan, dan dalam kasus yang sangat parah, masalah kardiovaskular.'},
    {'question': 'Bagaimana cara mengurangi nyeri akibat kifosis di rumah?', 'answer': 'Penggunaan kompres panas atau dingin, obat pereda nyeri yang diresepkan dokter, dan latihan peregangan bisa membantu.'},
    {'question': 'Apakah terapi alternatif bermanfaat untuk kifosis?', 'answer': 'Beberapa terapi alternatif seperti akupunktur atau yoga bisa membantu, tetapi sebaiknya dikonsultasikan terlebih dahulu dengan dokter.'},
    {'question': 'Apakah penggunaan komputer atau gadget mempengaruhi kifosis?', 'answer': 'Penggunaan yang berkepanjangan dengan postur yang buruk dapat memperburuk kifosis. Penting untuk menjaga postur yang baik saat menggunakan gadget.'},
    {'question': 'Bagaimana cara memilih brace yang tepat untuk anak?', 'answer': 'Pemilihan brace harus dilakukan oleh dokter spesialis ortopedi atau ahli terapi fisik yang berpengalaman.'},
    {'question': 'Apakah anak dengan kifosis bisa melakukan aktivitas sehari-hari secara normal?', 'answer': 'Ya, dengan penanganan yang tepat, anak dapat melakukan aktivitas sehari-hari secara normal.'},
    {'question': 'Bagaimana memotivasi anak untuk tetap menjalani terapi?', 'answer': 'Berikan pujian dan dorongan positif, buat terapi menjadi menyenangkan, dan libatkan anak dalam menetapkan tujuan terapi.'},
    {'question': 'Apakah kifosis mempengaruhi kehidupan jangka panjang anak?', 'answer': 'Dengan penanganan yang tepat, banyak anak dengan kifosis dapat menjalani kehidupan normal dan aktif tanpa masalah jangka panjang yang signifikan.'},
    {'question': 'Bagaimana kifosis mempengaruhi kepercayaan diri anak?', 'answer': 'Kifosis bisa mempengaruhi kepercayaan diri anak karena perubahan postur yang terlihat. Dukungan emosional dari keluarga dan teman sangat penting.'},
    {'question': 'Apakah anak dengan kifosis bisa menjalani kehidupan normal?', 'answer': 'Ya, dengan perawatan yang tepat, anak dengan kifosis bisa menjalani kehidupan normal dan aktif.'},
    {'question': 'Bagaimana cara membantu anak mengatasi rasa malu karena kifosis?', 'answer': 'Bicarakan secara terbuka tentang kondisinya, dorong aktivitas yang meningkatkan kepercayaan diri, dan pertimbangkan konseling jika perlu.'},
    {'question': 'Apakah kifosis bisa menyebabkan depresi atau kecemasan pada anak?', 'answer': 'Kifosis bisa memicu perasaan negatif yang berujung pada depresi atau kecemasan. Mendukung kesehatan mental anak sangat penting.'},
    {'question': 'Bagaimana mendukung kesehatan mental anak dengan kifosis?', 'answer': 'Berikan dukungan emosional, dorong aktivitas sosial, dan cari bantuan profesional jika anak menunjukkan tanda-tanda stres atau depresi.'},
    {'question': 'Apakah perlu memberitahu teman-teman sekolah tentang kondisi anak?', 'answer': 'Keputusan ini sebaiknya didiskusikan dengan anak. Jika mereka setuju, penjelasan kepada teman-teman bisa membantu menciptakan lingkungan yang suportif.'},
    {'question': 'Bagaimana cara menjelaskan kifosis kepada anak?', 'answer': 'Jelaskan dengan bahasa yang mudah dimengerti bahwa kifosis adalah kondisi tulang belakang yang melengkung dan bagaimana cara mengelolanya.'},
    {'question': 'Apa dampak psikologis jangka panjang dari kifosis?', 'answer': 'Dampak psikologis bisa bervariasi. Dukungan terus-menerus dan pendekatan yang holistik dalam perawatan bisa membantu mengurangi dampak negatif.'},
    {'question': 'Bagaimana membantu anak menghadapi komentar negatif atau bullying?', 'answer': 'Latih anak untuk merespons dengan percaya diri, berikan strategi untuk menghadapi bullying, dan laporkan jika terjadi di lingkungan sekolah.'},
    {'question': 'Perlukah anak menemui psikolog?', 'answer': 'Jika anak menunjukkan tanda-tanda stres, kecemasan, atau depresi yang berkaitan dengan kifosis, konsultasi dengan psikolog dapat sangat membantu.'},
    {'question': 'Bagaimana kifosis mempengaruhi interaksi sosial anak?', 'answer': 'Kifosis bisa mempengaruhi interaksi sosial anak jika mereka merasa tidak percaya diri atau mengalami bullying.'},
    {'question': 'Apa peran keluarga dalam mendukung anak dengan kifosis?', 'answer': 'Keluarga harus memberikan dukungan emosional, membantu perawatan medis, dan memastikan anak merasa dicintai dan diterima.'},
    {'question': 'Apakah anak dengan kifosis bisa berolahraga?', 'answer': 'Ya, anak dengan kifosis bisa berolahraga, namun mungkin perlu menyesuaikan jenis olahraga dan mengikuti anjuran dokter.'},
    {'question': 'Bagaimana lingkungan sekolah bisa mendukung anak dengan kifosis?', 'answer': 'Lingkungan sekolah bisa mendukung dengan menyediakan penyesuaian fisik jika diperlukan dan memastikan anak tidak mengalami diskriminasi atau bullying.'},
    {'question': 'Apakah anak dengan kifosis memerlukan perawatan khusus di sekolah?', 'answer': 'Tergantung pada keparahan kifosis, beberapa penyesuaian mungkin diperlukan seperti tempat duduk yang nyaman atau waktu istirahat lebih sering.'},
    {'question': 'Bagaimana cara mendidik orang lain tentang kifosis?', 'answer': 'Edukasi bisa dilakukan melalui diskusi, presentasi di sekolah, atau penyebaran informasi melalui media sosial dan komunitas lokal.'},
    {'question': 'Apakah kifosis mempengaruhi kemampuan anak dalam kegiatan ekstrakurikuler?', 'answer': 'Tergantung pada kegiatan tersebut, beberapa penyesuaian mungkin diperlukan, namun banyak anak dengan kifosis tetap bisa ikut serta dalam kegiatan ekstrakurikuler.'},
    {'question': 'Bagaimana mengatasi stigma sosial terhadap kifosis?', 'answer': 'Edukasi, kampanye kesadaran, dan menciptakan lingkungan inklusif yang menghargai perbedaan bisa membantu mengatasi stigma.'},
    {'question': 'Apakah anak dengan kifosis perlu ikut serta dalam kelompok dukungan?', 'answer': 'Kelompok dukungan bisa sangat bermanfaat bagi anak dan orang tua untuk berbagi pengalaman dan mendapatkan dukungan dari orang lain yang menghadapi kondisi serupa.'},
    {'question': 'Bagaimana menjaga hubungan positif dengan teman sebaya untuk anak dengan kifosis?', 'answer': 'Dorong anak untuk tetap aktif dalam kegiatan sosial, bantu mereka membangun kepercayaan diri, dan ajari mereka untuk berkomunikasi secara terbuka tentang kondisinya.'},
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredFaqs = faqs.where((faq) {
      return faq['question'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              hintText: 'Cari Pertanyaan',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredFaqs.length,
        itemBuilder: (context, index) {
          final faq = filteredFaqs[index];
          return Column(
            children: [
              FAQTile(
                question: faq['question'],
                answer: faq['answer'],
                onTap: () {
                  setState(() {
                    // You may implement additional functionality if needed
                  });
                },
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}

class FAQTile extends StatelessWidget {
  final String question;
  final String answer;
  final VoidCallback onTap;

  FAQTile({required this.question, required this.answer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      title: Text(
        question,
        style: TextStyle(fontSize: 16.0),
      ),
      subtitle: Text(
        answer,
        style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
      ),
      onTap: onTap,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FAQPage(),
  ));
}
