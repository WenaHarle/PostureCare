import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import '../gradient_utils.dart';

class BraceManagementPage extends StatefulWidget {
  @override
  _BraceManagementPageState createState() => _BraceManagementPageState();
}

class _BraceManagementPageState extends State<BraceManagementPage> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  Map<String, dynamic> _braceData = {};
  Map<String, dynamic> _therapyProtocolData = {}; // New map for therapy protocol data
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchBraceData();
  }

  Future<void> _fetchBraceData() async {
    try {
      // Fetch Brace Data
      DatabaseEvent braceEvent = await _databaseReference.child('Brace').once();
      DataSnapshot braceSnapshot = braceEvent.snapshot;

      // Fetch Therapy Protocol Data
      DatabaseEvent therapyEvent = await _databaseReference.child('TherapyProtocol').once();
      DataSnapshot therapySnapshot = therapyEvent.snapshot;

      if (braceSnapshot.exists && braceSnapshot.value != null) {
        setState(() {
          _braceData = Map<String, dynamic>.from(braceSnapshot.value as Map);
        });
      } else {
        setState(() {
          _errorMessage = 'Data tidak ditemukan';
        });
      }

      // Process therapy protocol data if it exists
      if (therapySnapshot.exists && therapySnapshot.value != null) {
        setState(() {
          _therapyProtocolData = Map<String, dynamic>.from(therapySnapshot.value as Map);
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: buildGradient(),
          ),
        ),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(
        child: Text(
          _errorMessage,
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Brace Data:'),
            const SizedBox(height: 16),
            _buildBraceData(),
            const SizedBox(height: 32),
            _buildSectionTitle('Protokol Terapi Thermotherapy:'),
            const SizedBox(height: 16),
            _buildTherapyProtocolData(), // New section for therapy protocol
            const SizedBox(height: 32),
            _buildSectionTitle('Dokumentasi Foto:'),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
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

  // New method to display therapy protocol data
  Widget _buildTherapyProtocolData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTherapyCard('Jenis Terapi', _therapyProtocolData['Jenis Terapi']),
        _buildTherapyCard('Durasi', _therapyProtocolData['Durasi']),
        _buildTherapyCard('Frekuensi', _therapyProtocolData['Frekuensi']),
        _buildTherapyCard('Instruksi', _therapyProtocolData['Instruksi']),
      ],
    );
  }

  // Cards for displaying therapy protocol data
  Widget _buildTherapyCard(String title, dynamic value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        shadowColor: Colors.grey.withOpacity(0.3),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          leading: Icon(_getIconForTherapy(title), color: Colors.blue.shade600), // Different color for therapy data
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            value != null ? value.toString() : 'N/A',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }

  // Function to map relevant icons for therapy protocol
  IconData _getIconForTherapy(String title) {
    switch (title) {
      case 'Jenis Terapi':
        return Icons.spa;
      case 'Durasi':
        return Icons.timer;
      case 'Frekuensi':
        return Icons.repeat;
      case 'Instruksi':
        return Icons.menu_book;
      default:
        return Icons.info; // Default icon
    }
  }

  // Function to map relevant icons for brace data
  IconData _getIconForTitle(String title) {
    switch (title) {
      case 'Brace':
        return Icons.healing;
      case 'Model':
        return Icons.architecture;
      case 'Pelepasan':
        return Icons.timer_off;
      case 'Penyesuaian':
        return Icons.build;
      case 'Tanggal Pemasangan':
        return Icons.calendar_today;
      case 'Ukuran':
        return Icons.straighten;
      default:
        return Icons.info; // Default icon
    }
  }

  Widget _buildBraceCard(String title, dynamic value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        shadowColor: Colors.grey.withOpacity(0.3),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          leading: Icon(_getIconForTitle(title), color: Colors.orange.shade600),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            value != null ? value.toString() : 'N/A',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.orange.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
