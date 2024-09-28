import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaterControlPage extends StatefulWidget {
  @override
  _HeaterControlPageState createState() => _HeaterControlPageState();
}

class _HeaterControlPageState extends State<HeaterControlPage> {
  double _temperature = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getTemperature();
  }

  Future<void> _getTemperature() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Heaters')
          .doc('Data') 
          .get();

      if (doc.exists && doc.data() != null) {
        setState(() {
          _temperature = doc['temperature'] ?? 0.0;
        });
      } else {
        setState(() {
          _temperature = 0.0;
        });
      }
    } catch (e) {
      setState(() {
        _temperature = 0.0;
      });
      print('Error getting temperature: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Heater Temperature',
          style: GoogleFonts.poppins(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.thermostat,
                      color: _temperature > 30.0 ? Colors.red : Colors.blue,
                      size: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Current Temperature: ${_temperature.toStringAsFixed(1)}°C',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
        ),
      ),
    );
  }
}
