import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyProgressPage extends StatefulWidget {
  @override
  _WeeklyProgressPageState createState() => _WeeklyProgressPageState();
}

class _WeeklyProgressPageState extends State<WeeklyProgressPage> {
  List<FlSpot> _spots = [];
  bool _loading = true;
  String _errorMessage = '';
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _fetchWeeklyData();
  }

  Future<void> _fetchWeeklyData() async {
    try {
      final weekKey = (DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1))).millisecondsSinceEpoch.toString();
      DatabaseEvent event = await _databaseReference.child('WeeklyData/$weekKey').once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists && snapshot.value != null) {
        Map<dynamic, dynamic> weekData = snapshot.value as Map<dynamic, dynamic>;
        int dayIndex = 0;
        weekData.forEach((key, value) {
          List<dynamic> data = List.from(value as Iterable);
          if (data.isNotEmpty) {
            double sum = data.fold(0, (previousValue, element) => previousValue + element);
            double average = sum / data.length;
            _spots.add(FlSpot(dayIndex.toDouble(), average));
          }
          dayIndex++;
        });

        setState(() {
          _spots = _spots;
        });
      } else {
        setState(() {
          _errorMessage = 'Data tidak ditemukan';
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
        backgroundColor: Colors.orange,
        title: const Text('Progress Mingguan'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(child: Text(_errorMessage))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
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
                              borderRadius: BorderRadius.circular(20),
                              child: LineChart(
                                LineChartData(
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
                                          : [FlSpot(0, 0), FlSpot(1, 1), FlSpot(2, 2)],
                                      isCurved: true,
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
                                        getTitlesWidget: (value, meta) {
                                          return Text('${value.toInt()}°');
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
