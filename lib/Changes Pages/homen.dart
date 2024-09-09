  import 'package:eko_sortify_app/Changes%20Pages/homen_page.dart';
  import 'package:eko_sortify_app/Changes%20Pages/profile_page_2.dart';
  import 'package:eko_sortify_app/Components/bottom_nav_bar.dart';
  import 'package:eko_sortify_app/Pages/centers_page.dart';
  import 'package:eko_sortify_app/Service/authentication/auth_service.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:eko_sortify_app/Pages/locations_page.dart';

  class Homen extends StatefulWidget {
    const Homen({super.key});

    @override
    State<Homen> createState() => _HomenState();
  }

  class _HomenState extends State<Homen> {

    final AuthService _auth = AuthService();
    
    int _selectedIndex = 0;

    void navigationBottomBar(int index){
      setState(() {
        _selectedIndex = index;
      });
    }

    late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomenPage(),
      const LocationsPage(),
      CentersPage(),
      ProfilePage2(
        uid: _auth.getCurrentUid(),
      )
    ];
  }

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