import 'package:eko_sortify_app/Components/catagory_card.dart';
import 'package:eko_sortify_app/Pages/Sorting%20Button/ewaste_page.dart';
import 'package:eko_sortify_app/Pages/Sorting%20Button/medical_waste_page.dart';
import 'package:eko_sortify_app/Pages/Sorting%20Button/organic_waste.dart';
import 'package:eko_sortify_app/Pages/Sorting%20Button/plastic_page.dart';
import 'package:eko_sortify_app/Pages/Sorting%20Button/radio_active_page.dart';
import 'package:eko_sortify_app/Pages/Sorting%20Button/recycle_waste_page.dart';
import 'package:flutter/material.dart';

class SortingPage extends StatelessWidget {
  const SortingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        elevation: 0,
        title: Text(
            "Hello, User!",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(Icons.person, color: Colors.white,),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Let's start to sort now !!",
              style: TextStyle(
                color: Color.fromARGB(255, 3, 180, 12),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(Icons.menu, color: Colors.grey[700]),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "What you want to sort?",
                      ),
                    ),
                  ),
                  const Icon(Icons.search,
                      color: Color.fromARGB(255, 152, 144, 144)),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Popular",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 26),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  CategoryCard(
                    label: "Plastics",
                    imagePath: 'assets/sorting/battery.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlasticPage(),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    label: "Medicine Waste",
                    imagePath: 'assets/sorting/medicine.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedicineWastePage(),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    label: "E-Waste and Batteries",
                    imagePath: 'assets/sorting/organic.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EWastePage(),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    label: "Radio-Active Waste",
                    imagePath: 'assets/sorting/plastic.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RadioactivePage(),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    label: "Organic Waste",
                    imagePath: 'assets/sorting/radioactive.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrganicWastePage(),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    label: "Recyclable Waste",
                    imagePath: 'assets/sorting/recycle.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecyclableWastePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
