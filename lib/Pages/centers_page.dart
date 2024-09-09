import 'package:eko_sortify_app/Pages/Centers/eco_store.dart';
import 'package:eko_sortify_app/Pages/Centers/nearest_takeout.dart';
import 'package:eko_sortify_app/Pages/Centers/recycle_center.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CentersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recycle Centers',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RecycleCenterList(),
    );
  }
}

class RecycleCenterList extends StatelessWidget {
  final List<Map<String, String>> recycleCenters = [
    {
      'name': 'Jahas Impex',
      'address': '112A, Anna Salai, Puducherry',
      'description': 'Distributor Of Waste Paper, Plastic Scraps',
      'image': 'assets/centers/image1.jpeg',
    },
    {
      'name': 'EWaste Recycler',
      'address': '111, Opp To AFT, Puducherry',
      'description': 'Distributor Of Waste Paper, Plastic Scraps',
      'image': 'assets/centers/image2.webp',
    },
    {
      'name': 'Waste Recycler',
      'address': '111, Opp To AFT, Puducherry',
      'description': 'Distributor Of Waste Paper, Plastic Scraps',
      'image': 'assets/centers/image1.jpeg',
    },
    {
      'name': 'William Impex',
      'address': '112A, Anna Salai, Puducherry',
      'description': 'Distributor Of Waste Paper, Plastic Scraps',
      'image': 'assets/centers/image1.jpeg',
    },
    {
      'name': ' Recycler',
      'address': '111, Opp To AFT, Puducherry',
      'description': 'Distributor Of Waste Paper, Plastic Scraps',
      'image': 'assets/centers/image2.webp',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recycle Centers'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            );
          },
        ),
        // Remove actions to eliminate the menu icon on the right
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.store,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    'Ecostore',
                    style: GoogleFonts.sora(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EcoStore(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10,),
            
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.store,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    'Nearest Takeout',
                    style: GoogleFonts.sora(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NearestTakeOut(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Recycle Centers',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                // Implement search functionality here
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Discover Recycle Centers Near You',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: recycleCenters.length,
              itemBuilder: (context, index) {
                final center = recycleCenters[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            center['image']!,
                            width: 400,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          center['name']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          center['address']!,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          center['description']!,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecycleCentre(center),
                                ),
                              );
                            },
                            child: Text('View Details'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
