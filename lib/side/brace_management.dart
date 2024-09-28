import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart'; // For custom fonts

class BraceManagementPage extends StatefulWidget {
  @override
  _BraceManagementPageState createState() => _BraceManagementPageState();
}

class _BraceManagementPageState extends State<BraceManagementPage> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  Map<String, dynamic> _braceData = {};
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchBraceData();
  }

  Future<void> _fetchBraceData() async {
    try {
      // Fetch data from 'Brace' node in Firebase
      DatabaseEvent event = await _databaseReference.child('Brace').once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists && snapshot.value != null) {
        setState(() {
          _braceData = Map<String, dynamic>.from(snapshot.value as Map);
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
        title: Text(
          'Brace Management',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange.shade600,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage, style: TextStyle(color: Colors.red, fontSize: 18)))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Brace Data:',
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            _buildBraceData(),
            Text(
              'Protokol Terapi Thermotheraphy:',
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            Text(
              'Dokumentasi Foto:',
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100], // Light grey background
    );
  }

  Widget _buildBraceData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBraceCard('Brace', _braceData['Brace']),
        _buildBraceCard('Model', _braceData['Model']),
        _buildBraceCard('Pelepasan', _braceData['Pelepasan']),
        _buildBraceCard('Penyesuaian', _braceData['Penyesuaian']),
        _buildBraceCard('Tanggal Pemasangan', _braceData['Tanggal pemasangan']),
        _buildBraceCard('Ukuran', _braceData['Ukuran']),
      ],
    );
  }

  Widget _buildBraceCard(String title, dynamic value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(Icons.healing, color: Colors.orange.shade600),
        title: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          value != null ? value.toString() : 'N/A',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}
