import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecycleCentre extends StatelessWidget {
  final Map<String, String> center;

  RecycleCentre(this.center);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(center['name']!),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              center['image']!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                center['name']!,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Contact: +123-444-666',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Hours: Mon-Fri 6am-11pm',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 149, 255, 177),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MATERIALS ACCEPTED',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.newspaper),
                      SizedBox(width: 8),
                      Text('Paper: Newspapers, Magazines, Office'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.local_drink),
                      SizedBox(width: 8),
                      Text('Plastics: Bottles, Containers, Bags'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 8),
                      Text('Metals: Cans, Foil, Scrap Metals'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Directions and map',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Image.asset(
              'assets/centers/map.png', // Replace with the actual map image
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle directions click
                },
                child: Text('Get Direction'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'User Reviews',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildReviewCard(
                'Emily Johnson', '2 days ago', 5, 'assets/user.jpg'),
            _buildReviewCard('Emily', '2 days ago', 4, 'assets/user_alt.jpg'),
            SizedBox(height: 30),
            Text(
              'Quick Links',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildQuickLink('Find a recycle center'),
            _buildQuickLink('Recycle Tips'),
            _buildQuickLink('What to recycle'),
            _buildQuickLink('FAQ'),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Contact: info@ekosortiy.com'),
                Spacer(),
                FaIcon(FontAwesomeIcons.facebook, size: 24),
                SizedBox(width: 10),
                FaIcon(FontAwesomeIcons.twitter, size: 24),
                SizedBox(width: 10),
                FaIcon(FontAwesomeIcons.instagram, size: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Define the _buildReviewCard method here
  Widget _buildReviewCard(
      String name, String timeAgo, int rating, String imagePath) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(name),
        subtitle: Row(
          children: [
            Icon(Icons.star, color: Colors.yellow, size: 20),
            SizedBox(width: 4),
            Text('$rating stars'),
          ],
        ),
        trailing: Text(timeAgo),
      ),
    );
  }

  // Define the _buildQuickLink method here
  Widget _buildQuickLink(String text) {
    return ListTile(
      leading: Icon(Icons.link),
      title: Text(text),
      onTap: () {
        // Handle quick link click
      },
    );
  }
}
