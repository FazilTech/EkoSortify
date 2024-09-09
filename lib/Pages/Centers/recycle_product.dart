import 'package:eko_sortify_app/Pages/Centers/checkout_page.dart';
import 'package:flutter/material.dart';

class RecycledProduct extends StatelessWidget {
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
        centerTitle: true,
        title: Text(
          'Recycled Products',
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
                  hintText: 'Search recycled products',
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
              // List of Recycled Products
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Top Picks',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  RecycledProductCard(
                    image:
                        'assets/centers/popular_item3.jpg', // Replace with your image asset
                    title: 'Recycled Tote Bag',
                    price: '\$15.99',
                  ),
                  SizedBox(height: 20),
                  RecycledProductCard(
                    image:
                        'assets/centers/popular_item1.jpg', // Replace with your image asset
                    title: 'Eco-Friendly Water Bottle',
                    price: '\$9.99',
                  ),
                  SizedBox(height: 20),
                  RecycledProductCard(
                    image:
                        'assets/centers/popular_item2.jpg', // Replace with your image asset
                    title: 'Recycled Paper Notebook',
                    price: '\$5.99',
                  ),
                  SizedBox(height: 20),
                  RecycledProductCard(
                    image:
                        'assets/centers/banner_image.jpg', // Replace with your image asset
                    title: 'Bamboo Toothbrush',
                    price: '\$3.50',
                  ),
                  SizedBox(height: 20),
                  RecycledProductCard(
                    image:
                        'assets/centers/image1.jpeg', // Replace with your image asset
                    title: 'Recycled Cotton T-Shirt',
                    price: '\$25.00',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecycledProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;

  RecycledProductCard({
    required this.image,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  price,
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 113, 219, 117),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final String title;

  ProductDetailPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Details of $title',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
