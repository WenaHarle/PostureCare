import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'progress.dart';
import 'package:google_fonts/google_fonts.dart';

class GraphPage extends StatefulWidget {
  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  List<FlSpot> _spots = [];
  double _angle = 14;
  bool _loading = true;
  String _errorMessage = '';
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
      _spots.clear(); // Bersihkan data sebelumnya
    });

    try {
      // Query untuk mendapatkan 7 data terbaru dari Firebase
      DatabaseEvent event = await _databaseReference
          .child('Data')
          .orderByKey()
          .limitToLast(7)
          .once();

      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists && snapshot.value != null) {
        print('Data snapshot: ${snapshot.value}');  // Debug log

        // Mengubah snapshot menjadi map
        Map<dynamic, dynamic> dataMap = snapshot.value as Map<dynamic, dynamic>;

        // Mengurutkan data berdasarkan key (epoch time)
        List<MapEntry<dynamic, dynamic>> sortedData = dataMap.entries.toList()
          ..sort((a, b) => int.parse(a.key).compareTo(int.parse(b.key)));

        // Loop untuk mengambil nilai SensorCervical dari setiap entry
        for (int i = 0; i < sortedData.length; i++) {
          var entry = sortedData[i];
          var data = entry.value as Map<dynamic, dynamic>;

          if (data.containsKey('SensorCervical')) {
            double sensorValue = data['SensorCervical'].toDouble();

            // Menambah data ke grafik
            setState(() {
              _spots.add(FlSpot(i.toDouble(), sensorValue));

              // Update _angle jika data terbaru (terakhir) ditemukan
              if (i == sortedData.length - 1) {
                _angle = sensorValue; // Nilai terbaru untuk _angle
              }
            });

            // Simpan juga data ke WeeklyData
            await _databaseReference.child('WeeklyData/${entry.key}').set(data);
          } else {
            setState(() {
              _errorMessage = 'Data tidak ditemukan (key SensorCervical tidak ada)';
            });
          }
        }
      } else {
        setState(() {
          _errorMessage = 'Data tidak ditemukan (snapshot kosong)';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Terjadi kesalahan: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Bone Angle Changes',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WeeklyProgressPage(),
              ));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          _loading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FullScreenGraphPage(spots: _spots),
                      ));
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0), // Remove rounded corners
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LineChart(
                            LineChartData(
                              minX: 0,
                              maxX: 6,
                              minY: 0,
                              maxY: 45,
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: true,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: Colors.grey,
                                    strokeWidth: 1,
                                  );
                                },
                                getDrawingVerticalLine: (value) {
                                  return FlLine(
                                    color: Colors.grey,
                                    strokeWidth: 1,
                                  );
                                },
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: _spots.isNotEmpty
                                      ? _spots
                                      : [FlSpot(0, 40), FlSpot(1, 25), FlSpot(2, 20), FlSpot(3, 33), FlSpot(4, 40), FlSpot(5, 20), FlSpot(6, 30)],
                                  isCurved: false,
                                  color: Colors.blue,
                                  barWidth: 4,
                                  belowBarData: BarAreaData(show: false),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 22,
                                    interval: 1,
                                    getTitlesWidget: (value, meta) {
                                      const days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
                                      return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        space: 4.0,
                                        child: Text(days[value.toInt() % days.length]),
                                      );
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 28,
                                    interval: 5,
                                    getTitlesWidget: (value, meta) {
                                      return Text('${value.toInt()}°');
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Sudut Lengkungan: $_angle°',
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            // ini belum tau
                          },
                          child: Text(
                            'Hubungi Dokter?',
                            style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenGraphPage extends StatelessWidget {
  final List<FlSpot> spots;

  FullScreenGraphPage({required this.spots});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          title: Text('Full Screen Graph',
            style: GoogleFonts.poppins(),
          )
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 6,
            minY: 0,
            maxY: 45,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey,
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey,
                  strokeWidth: 1,
                );
              },
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots.isNotEmpty
                    ? spots
                    : [FlSpot(0, 40), FlSpot(1, 25), FlSpot(2, 20), FlSpot(3, 33), FlSpot(4, 40), FlSpot(5, 20), FlSpot(6, 30)],
                isCurved: false,
                color: Colors.blue,
                barWidth: 4,
                belowBarData: BarAreaData(show: false),
              ),
            ],
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    const days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 4.0,
                      child: Text(days[value.toInt() % days.length]),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: 5,
                  getTitlesWidget: (value, meta) {
                    return Text('${value.toInt()}°');
                  },
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
