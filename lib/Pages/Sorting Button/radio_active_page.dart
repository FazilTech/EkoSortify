import 'package:flutter/material.dart';

class RadioactivePage extends StatelessWidget {
  const RadioactivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'E Waste Sorting',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImageSection(),
            _buildTitleSection(),
            _buildInfoSection(),
            _buildMethodsSection(),
            _buildRecyclingTipsSection(),
          ],
        ),
      ),
    );
  }

  // Image Section
  Widget _buildImageSection() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/sorting/ewaste1.png'), // Replace with your image
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Title Section
  Widget _buildTitleSection() {
    return  Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is E-Waste?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Electronic waste (e-waste) refers to discarded electronic devices such as phones, computers, and televisions.',
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  // Info Section
  Widget _buildInfoSection() {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Should We Sort E-Waste?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Properly sorting e-waste ensures that harmful chemicals are not released into the environment, '
            'and precious metals like gold and silver can be recycled from old devices.',
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  // Methods Section
  Widget _buildMethodsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Methods of E-Waste Sorting',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          _buildMethodCard(
              'Manual Sorting', 'Sorting by hand to extract valuable parts.'),
          _buildMethodCard('Magnetic Separation',
              'Using magnets to separate metallic components.'),
          _buildMethodCard('Shredding',
              'Breaking down electronic devices into smaller pieces.'),
          _buildMethodCard('Chemical Extraction',
              'Extracting valuable metals using chemicals.'),
        ],
      ),
    );
  }

  Widget _buildMethodCard(String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Recycling Tips Section
  Widget _buildRecyclingTipsSection() {
    return  Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'E-Waste Recycling Tips',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '1. Donate working electronics to charities.\n'
            '2. Return old devices to manufacturers for proper disposal.\n'
            '3. Avoid mixing e-waste with regular trash.',
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
