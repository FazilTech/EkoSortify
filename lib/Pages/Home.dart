import 'package:eko_sortify_app/Components/bottom_nav_bar.dart';
import 'package:eko_sortify_app/Pages/Home_Page.dart';
import 'package:eko_sortify_app/Pages/centers_page.dart';
import 'package:eko_sortify_app/Pages/location_page.dart';
import 'package:eko_sortify_app/Pages/profile_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  int _selectedIndex = 0;

  void navigationBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const LocationPage(),
    const CentersPage(),
    const ProfilePage() 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(
        onTabChange: (index)=> navigationBottomBar(index),
      ),
      body: _pages[_selectedIndex]
    );
  }
}