import 'package:flutter/material.dart';

class NearestTakeOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest TechOut'),
      ),
      body: Center(
        child: Text(
          'Welcome to Nearest TechOut',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
