import 'package:flutter/material.dart';

class MedicineWastePage extends StatelessWidget {
  const MedicineWastePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medicine Waste Sorting',
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
      height: 350,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/sorting/medicine1.png'), // Replace with your image
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
            'What is Medicine Waste?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Pharmaceutical waste refers to expired, unused, or contaminated medications that are no longer needed and require proper disposal.',
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
            'Why Should We Sort Medicine Waste?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Prevent Environmental Contamination, '
            'Proper sorting ensures that harmful chemicals in medicine waste do not enter water systems, soil, or ecosystems, reducing pollution.',
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
            'Methods of Medicine Waste Sorting',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          _buildMethodCard('Source Segregation',
              'Separate hospitals source into categories like expired, unused.'),
          _buildMethodCard('Color-Coded Bins',
              'Use specific colored bins to classify medicine waste.'),
          _buildMethodCard('Barcode/Label Scanning',
              'identify and sort medicines based on their composition, expiration.'),
          _buildMethodCard('Manual Sorting',
              'Trained personnel manually sort medicine waste into categories .'),
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
            'Medicine Waste Recycling Tips',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '1. Return Unused Medications.\n'
            '2. Follow Local Guidelines.\n'
            '3. Avoid Flushing Medications.\n'
            '4. Use Specialized Disposal Containers',
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
