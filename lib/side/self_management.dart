import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelfManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Self Management', style: TextStyle(fontFamily: 'Montserrat')),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildCard(
              context,
              title: 'Pengingat Aktivitas Fisik & Diet',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Aktivitas Fisik:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[600],
                    ),
                  ),
                  Text(
                    '• Lakukan peregangan setiap hari.\n• Lakukan terapi bermain setiap hari.\n• Lakukan olahraga mingguan.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  DietWidget(),
                ],
              ),
            ),
            _buildCard(
              context,
              title: 'Pengingat Kontrol Kunjungan',
              content: Text(
                '• Jadwal kunjungan kontrol ke fasilitas kesehatan sesuai dengan rekomendasi dokter.\n• Kunjungi fasilitas kesehatan untuk terapi medis lainnya.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HealthCareCalculationPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text('Kalkulasi Perawatan Kesehatan', style: TextStyle(fontFamily: 'Montserrat')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required String title, required Widget content}) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800],
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 10),
            content,
          ],
        ),
      ),
    );
  }
}

class DietWidget extends StatefulWidget {
  @override
  _DietWidgetState createState() => _DietWidgetState();
}

class _DietWidgetState extends State<DietWidget> {
  int _currentDay = DateTime.now().weekday - 1;

  final List<Map<String, dynamic>> _dietPlan = [
    {
      'day': 'Senin',
      'pagi': 'Oatmeal dengan buah segar.',
      'siang': 'Ayam panggang dengan sayuran.',
      'sore': 'Ikan bakar dengan nasi merah.',
      'snack': 'Buah dan yogurt.',
    },
    {
      'day': 'Selasa',
      'pagi': 'Roti gandum dengan telur orak-arik.',
      'siang': 'Salad sayuran dengan dada ayam.',
      'sore': 'Sup sayuran dengan tahu.',
      'snack': 'Smoothie buah.',
    },
    {
      'day': 'Rabu',
      'pagi': 'Smoothie pisang dengan selai kacang.',
      'siang': 'Nasi merah dengan daging sapi panggang.',
      'sore': 'Ikan panggang dengan quinoa.',
      'snack': 'Kacang almond.',
    },
    {
      'day': 'Kamis',
      'pagi': 'Pancake gandum dengan sirup maple.',
      'siang': 'Sandwich sayuran dan keju.',
      'sore': 'Salmon panggang dengan kentang.',
      'snack': 'Buah segar.',
    },
    {
      'day': 'Jumat',
      'pagi': 'Yogurt dengan granola.',
      'siang': 'Tahu goreng dengan sayuran.',
      'sore': 'Nasi merah dengan ayam kari.',
      'snack': 'Salad buah.',
    },
    {
      'day': 'Sabtu',
      'pagi': 'Telur rebus dengan roti gandum.',
      'siang': 'Ikan bakar dengan sayuran.',
      'sore': 'Ayam bakar dengan ubi.',
      'snack': 'Kacang-kacangan.',
    },
    {
      'day': 'Minggu',
      'pagi': 'Roti panggang alpukat.',
      'siang': 'Salad quinoa dengan ayam panggang.',
      'sore': 'Tumis sayuran dengan tempe.',
      'snack': 'Biskuit gandum.',
    },
  ];

  void _nextDay() {
    setState(() {
      _currentDay = (_currentDay + 1) % _dietPlan.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final diet = _dietPlan[_currentDay];
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Diet untuk ${diet['day']}:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Pagi: ${diet['pagi']}'),
            Text('Siang: ${diet['siang']}'),
            Text('Sore: ${diet['sore']}'),
            Text('Snack: ${diet['snack']}'),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _nextDay,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Ganti Hari'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthCareCalculationPage extends StatefulWidget {
  @override
  _HealthCareCalculationPageState createState() => _HealthCareCalculationPageState();
}

class _HealthCareCalculationPageState extends State<HealthCareCalculationPage> {
  TextEditingController _daysController = TextEditingController();
  TextEditingController _costPerVisitController = TextEditingController();
  String _totalCost = '';

  void _calculateTotalCost() {
    int days = int.tryParse(_daysController.text) ?? 0;
    double costPerVisit = double.tryParse(_costPerVisitController.text) ?? 0;
    double totalCost = days * costPerVisit;

    setState(() {
      _totalCost = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(totalCost);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulasi Perawatan Kesehatan', style: TextStyle(fontFamily: 'Montserrat')),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _daysController,
              decoration: InputDecoration(
                labelText: 'Jumlah Hari Perawatan',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _costPerVisitController,
              decoration: InputDecoration(
                labelText: 'Biaya Per Kunjungan',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _calculateTotalCost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text('Hitung Total Biaya', style: TextStyle(fontFamily: 'Montserrat')),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                _totalCost.isNotEmpty ? 'Total Biaya: $_totalCost' : '',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[800],
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SelfManagementPage(),
  ));
}
