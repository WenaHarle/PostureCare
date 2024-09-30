import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../gradient_utils.dart'; // Import the gradient utility

// Function to build Linear Gradient

// Main Patient Education Page
class EdukasiPasienPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar with gradient
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: buildGradient(),
            ),
          ),
          title: Text('Edukasi Pasien', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 4,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with image
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26, spreadRadius: 5)],
                image: DecorationImage(
                  image: AssetImage('assets/health_education.jpg'), // Add your image to the assets folder
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Kenal Kanal Dunia',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextButton('Detik Sehat', Colors.green, Icons.arrow_forward_ios, 'https://health.detik.com'),
                _buildTextButton('Kompas Sehat', Colors.blue, Icons.arrow_forward_ios, 'https://health.kompas.com'),
                _buildTextButton('CNN News', Colors.purple, Icons.arrow_forward_ios, 'https://www.cnnindonesia.com/gaya-hidup/kesehatan'),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Permainan',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KuisPage()),
                );
              },
              child: Text('Mainkan Kuis'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Function to launch URL using url_launcher
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

  // Create a text button widget with icon and URL
  Widget _buildTextButton(String text, Color color, IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(text, style: TextStyle(fontSize: 18, color: color)),
          trailing: Icon(Icons.arrow_forward, color: color),
          onTap: () {
            _launchURL(url); // Open link when button is tapped
          },
        ),
      ),
    );
  }
}

// Simple Quiz Page
class KuisPage extends StatefulWidget {
  @override
  _KuisPageState createState() => _KuisPageState();
}

class _KuisPageState extends State<KuisPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'question': 'Apa penyebab utama kifosis?',
      'answers': [
        {'text': 'Postur tubuh buruk', 'score': 1},
        {'text': 'Cedera kepala', 'score': 0},
        {'text': 'Masalah pernapasan', 'score': 0},
        {'text': 'Gangguan pencernaan', 'score': 0},
      ],
    },
    {
      'question': 'Apa yang sebaiknya digunakan oleh penderita kifosis?',
      'answers': [
        {'text': 'Korset kifosis', 'score': 1},
        {'text': 'Kacamata hitam', 'score': 0},
        {'text': 'Sarung tangan', 'score': 0},
        {'text': 'Helm', 'score': 0},
      ],
    },
    {
      'question': 'Berapa tahap perkembangan Erik Erikson?',
      'answers': [
        {'text': '6 tahap', 'score': 0},
        {'text': '7 tahap', 'score': 0},
        {'text': '8 tahap', 'score': 1},
        {'text': '9 tahap', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar with gradient
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: _buildGradient(),
            ),
          ),
          title: Text('Kuis Kifosis', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 4,
        ),
      ),
      body: _currentQuestionIndex < _questions.length
          ? _buildQuiz()
          : _buildResult(),
    );
  }

  Widget _buildQuiz() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _questions[_currentQuestionIndex]['question'] as String,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ...(_questions[_currentQuestionIndex]['answers']
          as List<Map<String, Object>>)
              .map((answer) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () => _answerQuestion(answer['score'] as int),
                child: Text(answer['text'] as String),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildResult() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Kuis Selesai!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Skor Anda: $_score/${_questions.length}',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the main page
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build Linear Gradient for Quiz
  LinearGradient _buildGradient() {
    return LinearGradient(
      colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)], // Purple to pink gradient
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posturecare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EdukasiPasienPage(),
    );
  }
}
