import 'package:flutter/material.dart';

class DukunganLainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dukungan Lain'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          'Dukungan Lain Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
