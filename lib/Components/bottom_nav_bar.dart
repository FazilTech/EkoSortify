import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({
    super.key,
    required this.onTabChange
    });

  void Function(int)? onTabChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: GNav(
        backgroundColor: Color.fromRGBO(59, 200, 100, 30),
        color: Colors.white,
        activeColor: Colors.black,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 70,
        onTabChange: (value)=> onTabChange!(value),
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
            textStyle: GoogleFonts.sora(
                color: Colors.white
              ),
            ),
          GButton(
            icon: Icons.location_pin,
            text: 'Location',
            textStyle: GoogleFonts.sora(
                color: Colors.white
              ),
            ),
            GButton(
              icon: Icons.recycling,
              text: 'Centers',
              textStyle: GoogleFonts.sora(
                color: Colors.white
              ),
              ),

            GButton(
              icon: Icons.person,
              text: 'Profile',
              textStyle: GoogleFonts.sora(
                color: Colors.white
              ),
              ),
              
        ]
        ),
    );
  }
}