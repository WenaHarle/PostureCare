import 'package:flutter/material.dart';

class SelfManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Self Management'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          'Self Management Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
