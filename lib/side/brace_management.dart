import 'package:flutter/material.dart';

class BraceManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brace Management'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          'Brace Management Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
