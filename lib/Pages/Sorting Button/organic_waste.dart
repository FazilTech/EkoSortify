import 'package:flutter/material.dart';

class OrganicWastePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organic Waste"),
        backgroundColor: const Color.fromARGB(255, 77, 219, 84),
      ),
      body: const Center(
        child: Text(
          "This is the Organic Waste page!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
