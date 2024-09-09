import 'package:flutter/material.dart';

class PlasticPage extends StatelessWidget {
  const PlasticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plastic Sorting',
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
      height: 400,
      width: 250,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/sorting/plastic1.png'),
          // Replace with your image
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Title Section
  Widget _buildTitleSection() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is Plastic?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Plastic waste refers to discarded  materials that  have been disposed of after their intended use',
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
            'Why Should We Sort Plastic?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Properly sorting plastic  ensures that harmful chemicals are not released. '
            'It ensures higher-quality recycled materials, reducing contamination and producing better end products.',
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
            'Methods of Plastic Sorting',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          _buildMethodCard(
              'Manual Sorting', 'Sorting by hand to extract valuable parts.'),
          _buildMethodCard('Density Separation',
              'sorted by density using water or air to separate lighter materials.'),
          _buildMethodCard('Near-Infrared (NIR)',
              'Uses infrared light to identify and sort plastics.'),
          _buildMethodCard('Electrostatic Separation',
              'separate plastics based on their electrical conductivity.'),
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
            'E-Waste Plastic Tips',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '1. Label Plastics Clearly.\n'
            '2. Pre-clean Plastics.\n'
            '3. Use Automated Sorting Technologies.',
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
