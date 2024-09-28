import 'package:flutter/material.dart';

class InformasiTenagaKesehatanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Tenaga Kesehatan'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          'Informasi Tenaga Kesehatan Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
