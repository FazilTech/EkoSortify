import 'package:eko_sortify_app/Pages/Centers/recycle_product.dart';
import 'package:flutter/material.dart';

class EcoStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF0F0F0),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.recycling, color: Colors.green),
        ),
        centerTitle: true, // Center the title
        title: Text(
          'Eco Store',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.green),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search your product',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20),
              // Banner Image with Discount
              Stack(
                children: [
                  Container(
                    height: 200, // Increase the height of the banner
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/centers/banner_image.jpg'), // Replace with your image asset
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '30% OFF',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          'ON ALL \nECO FRIENDLY \nPRODUCTS',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Category Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Explore',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CategoryCard(
                      image: 'assets/centers/clothing.png',
                      label: 'Clothing',
                    ),
                  ),
                  Expanded(
                    child: CategoryCard(
                      image: 'assets/centers/gardening.png',
                      label: 'Gardening',
                    ),
                  ),
                  Expanded(
                    child: CategoryCard(
                      image: 'assets/centers/kitchen.png',
                      label: 'Kitchen',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Popular Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child:
                        Text('View All', style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PopularItemCard(
                    image:
                        'assets/centers/popular_item1.jpg', // Replace with your image asset
                    discount: '20% Off',
                  ),
                  PopularItemCard(
                    image:
                        'assets/centers/popular_item2.jpg', // Replace with your image asset
                    discount: '20% Off',
                  ),
                  PopularItemCard(
                    image:
                        'assets/centers/popular_item3.jpg', // Replace with your image asset
                    discount: '20% Off',
                  ),
                ],
              ),
              SizedBox(height: 40),
              // Shop Now Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to RecycledProduct page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecycledProduct()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Shop Now',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// CategoryCard widget
class CategoryCard extends StatelessWidget {
  final String image;
  final String label;

  CategoryCard({required this.image, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

// PopularItemCard widget
class PopularItemCard extends StatelessWidget {
  final String image;
  final String discount;

  PopularItemCard({required this.image, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            color: Colors.green,
            child: Text(
              discount,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
