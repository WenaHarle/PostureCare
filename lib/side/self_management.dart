import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SelfManagementPage(),
  ));
}

class SelfManagementPage extends StatefulWidget {
  @override
  _SelfManagementPageState createState() => _SelfManagementPageState();
}

class _SelfManagementPageState extends State<SelfManagementPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  TextEditingController _activityController = TextEditingController();
  TextEditingController _visitController = TextEditingController();
  DateTime? _activityDate;
  DateTime? _visitDate;

  @override
  void initState() {
    super.initState();
    initializeNotifications();
    loadSavedData();
  }

  Future<void> initializeNotifications() async {
    tz.initializeTimeZones(); // Initialize timezone data
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _scheduleNotification(
      DateTime dateTime, String title, String body) async {
    var androidDetails = AndroidNotificationDetails(
      'channelId', 'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );

    var generalNotificationDetails =
    NotificationDetails(android: androidDetails);

    final tz.TZDateTime tzDateTime = tz.TZDateTime.from(dateTime, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tzDateTime,
      generalNotificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _activityController.text = prefs.getString('activity') ?? '';
      _visitController.text = prefs.getString('visit') ?? '';
      _activityDate =
          DateTime.tryParse(prefs.getString('activityDate') ?? '') ?? null;
      _visitDate =
          DateTime.tryParse(prefs.getString('visitDate') ?? '') ?? null;
    });
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('activity', _activityController.text);
    await prefs.setString('visit', _visitController.text);
    await prefs.setString('activityDate', _activityDate.toString());
    await prefs.setString('visitDate', _visitDate.toString());
  }

  Future<void> _selectDate(BuildContext context, bool isActivity) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (selectedDate != null) {
      setState(() {
        if (isActivity) {
          _activityDate = selectedDate;
        } else {
          _visitDate = selectedDate;
        }
      });
    }
  }

  void _setNotifications() {
    if (_activityDate != null) {
      DateTime today = DateTime.now();
      DateTime activityNotificationTime = DateTime(
          today.year, today.month, today.day, 7, 0); // 7 AM Notification
      _scheduleNotification(activityNotificationTime, "Pengingat Aktivitas Fisik",
          "Lakukan aktivitas fisik hari ini!");
    }

    if (_visitDate != null) {
      // H-3
      DateTime threeDaysBeforeVisit = _visitDate!.subtract(Duration(days: 3));
      DateTime notificationTimeH3 = DateTime(
          threeDaysBeforeVisit.year, threeDaysBeforeVisit.month,
          threeDaysBeforeVisit.day, 9, 0); // 9 AM on H-3
      _scheduleNotification(notificationTimeH3, "Pengingat Kontrol Kunjungan",
          "Jangan lupa kontrol kunjungan dalam 3 hari!");

      // H-2
      DateTime twoDaysBeforeVisit = _visitDate!.subtract(Duration(days: 2));
      DateTime notificationTimeH2 = DateTime(
          twoDaysBeforeVisit.year, twoDaysBeforeVisit.month,
          twoDaysBeforeVisit.day, 9, 0); // 9 AM on H-2
      _scheduleNotification(notificationTimeH2, "Pengingat Kontrol Kunjungan",
          "Jangan lupa kontrol kunjungan dalam 2 hari!");

      // H-1
      DateTime oneDayBeforeVisit = _visitDate!.subtract(Duration(days: 1));
      DateTime notificationTimeH1 = DateTime(
          oneDayBeforeVisit.year, oneDayBeforeVisit.month,
          oneDayBeforeVisit.day, 9, 0); // 9 AM on H-1
      _scheduleNotification(notificationTimeH1, "Pengingat Kontrol Kunjungan",
          "Kontrol kunjungan besok, jangan lupa persiapkan diri!");

      // Hari kunjungan (H)
      DateTime visitDayNotificationTime = DateTime(
          _visitDate!.year, _visitDate!.month, _visitDate!.day, 9, 0); // 9 AM on visit day
      _scheduleNotification(visitDayNotificationTime, "Pengingat Kontrol Kunjungan",
          "Hari ini adalah hari kontrol kunjungan. Semoga sehat selalu!");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Self Management',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            TextField(
              controller: _activityController,
              decoration: InputDecoration(
                labelText: 'Aktivitas Fisik',
                labelStyle: TextStyle(fontSize: 18, color: Colors.orange),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _activityDate != null
                        ? 'Tanggal Aktivitas Fisik: ${DateFormat('yyyy-MM-dd').format(_activityDate!)}'
                        : 'Pilih Tanggal Aktivitas Fisik',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _selectDate(context, true),
                  child: Text('Pilih Tanggal'),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _visitController,
              decoration: InputDecoration(
                labelText: 'Kontrol Kunjungan',
                labelStyle: TextStyle(fontSize: 18, color: Colors.orange),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _visitDate != null
                        ? 'Tanggal Kontrol Kunjungan: ${DateFormat('yyyy-MM-dd').format(_visitDate!)}'
                        : 'Pilih Tanggal Kontrol Kunjungan',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _selectDate(context, false),
                  child: Text('Pilih Tanggal'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  saveData();
                  _setNotifications();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Jadwal dan notifikasi berhasil disimpan')),
                  );
                },
                child: Text('Simpan Jadwal & Set Notifikasi', style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HealthCareCalculationPage()),
                  );
                },
                child: Text('Kalkulasi Perawatan Kesehatan', style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DietWidget()),
                  );
                },
                child: Text('Rencana Diet Harian', style: TextStyle(fontSize: 16)),
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
  _HealthCareCalculationPageState createState() =>
      _HealthCareCalculationPageState();
}

class _HealthCareCalculationPageState
    extends State<HealthCareCalculationPage> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  List<Map<String, dynamic>> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedEntries = prefs.getStringList('healthEntries');
    if (savedEntries != null) {
      setState(() {
        _entries = savedEntries.map((entry) {
          final parts = entry.split('|');
          return {'note': parts[0], 'price': double.parse(parts[1])};
        }).toList();
      });
    }
  }

  Future<void> _saveEntry(String note, double price) async {
    final prefs = await SharedPreferences.getInstance();
    _entries.add({'note': note, 'price': price});
    final List<String> saveEntries = _entries.map((entry) {
      return '${entry['note']}|${entry['price']}';
    }).toList();
    await prefs.setStringList('healthEntries', saveEntries);
  }

  void _addEntry() {
    final note = _noteController.text;
    final price = double.tryParse(_priceController.text);

    if (note.isNotEmpty && price != null) {
      _saveEntry(note, price);
      setState(() {
        _noteController.clear();
        _priceController.clear();
      });
    }
  }

  double _calculateTotal() {
    return _entries.fold(0.0, (sum, entry) => sum + entry['price']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kalkulasi Perawatan Kesehatan',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Catatan',
                labelStyle: TextStyle(fontSize: 18),
              ),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Harga',
                labelStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: StadiumBorder(),
              ),
              onPressed: _addEntry,
              child: Text('Tambah Biaya'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                  final entry = _entries[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(entry['note']),
                      subtitle:
                      Text('Harga: Rp${entry['price'].toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Total Biaya: Rp${_calculateTotal().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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
      'pagi': 'Oatmeal dengan susu almond dan buah-buahan (pisang, stroberi)',
      'siang': 'Nasi merah, ayam panggang, brokoli kukus',
      'sore': 'Sup wortel dan kentang, tahu rebus',
      'snack': 'Yoghurt rendah lemak dengan granola',
    },
    {
      'day': 'Selasa',
      'pagi': 'Roti gandum dengan selai kacang dan irisan apel',
      'siang': 'Ikan salmon panggang, nasi merah, bayam tumis',
      'sore': 'Tempe rebus, jagung rebus, sayur bayam',
      'snack': 'Smoothie bayam, alpukat, dan susu kedelai',
    },
    {
      'day': 'Rabu',
      'pagi': 'Telur rebus, roti gandum, dan alpukat',
      'siang': 'Ayam tumis dengan paprika, nasi putih, sayur sop',
      'sore': 'Ubi panggang, tahu kukus',
      'snack': 'Buah-buahan segar (apel, anggur)',
    },
    {
      'day': 'Kamis',
      'pagi': 'Smoothie pisang dan bayam',
      'siang': 'Ikan tuna panggang dengan kentang dan brokoli kukus',
      'sore': 'Tahu goreng, sayur lodeh',
      'snack': 'Buah pir dengan kacang almond',
    },
    {
      'day': 'Jumat',
      'pagi': 'Omelet sayuran dengan roti gandum',
      'siang': 'Nasi merah dengan ayam panggang dan sayur capcay',
      'sore': 'Sup jamur dengan tahu rebus',
      'snack': 'Kacang kedelai rebus',
    },
    {
      'day': 'Sabtu',
      'pagi': 'Pancake gandum dengan madu dan buah beri',
      'siang': 'Dada ayam panggang, salad bayam, nasi merah',
      'sore': 'Tumis tempe dengan jagung dan wortel',
      'snack': 'Yoghurt dengan chia seed',
    },
    {
      'day': 'Minggu',
      'pagi': 'Smoothie mangga dan pisang',
      'siang': 'Nasi putih dengan ikan bakar dan sayur asem',
      'sore': 'Tahu goreng dan gado-gado',
      'snack': 'Biskuit gandum dengan teh hijau',
    },
  ];

  void _nextDay() {
    setState(() {
      _currentDay = (_currentDay + 1) % _dietPlan.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPlan = _dietPlan[_currentDay];

    return Scaffold(
      appBar: AppBar(
        title: Text('Rencana Diet Harian'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hari: ${currentPlan['day']}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Sarapan: ${currentPlan['pagi']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Makan Siang: ${currentPlan['siang']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Makan Sore: ${currentPlan['sore']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Snack: ${currentPlan['snack']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Center(
              // child: ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blueAccent,
              //     shape: StadiumBorder(),
              //     padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              //   ),
              //   onPressed: _nextDay,
              //   child: Text('Hari Berikutnya', style: TextStyle(fontSize: 16)),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
