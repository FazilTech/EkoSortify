import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawerTile extends StatelessWidget {

  final String text;
  final IconData? icon;
  final void Function()? onTap;

  const MyDrawerTile({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ListTile(
        title: Text(
          text,
          style: GoogleFonts.sora(
            color: Color.fromRGBO(59, 200, 100, 10),
            fontSize: 17
          ),
        ),
        leading: Icon(
          icon,
          color: Color.fromRGBO(59, 200, 100, 10),
          size: 30,
        ),
        onTap: onTap,
      
    
      ),
    );
  }
}