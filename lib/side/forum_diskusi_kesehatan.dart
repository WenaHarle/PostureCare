import 'package:flutter/material.dart';

class ForumDiskusiKesehatanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum Diskusi Kesehatan'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          'Forum Diskusi Kesehatan Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
