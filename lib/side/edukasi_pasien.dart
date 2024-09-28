import 'package:flutter/material.dart';

class EdukasiPasienPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edukasi Pasien'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          'Edukasi Pasien Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
