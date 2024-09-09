import 'package:flutter/material.dart';

class RecyclableWastePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Waste and Batteries"),
        backgroundColor: const Color.fromARGB(255, 77, 219, 84),
      ),
      body: const Center(
        child: Text(
          "This is the E-Waste and Batteries page!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
