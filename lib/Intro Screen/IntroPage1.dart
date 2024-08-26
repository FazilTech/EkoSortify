import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// flutter pub add lottie

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 100),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Lottie.asset("assets/animation/Animation2.json"),
          ),

          const SizedBox(height: 5,),
          Center(
            child: Text(
              "Just a Click",
              textAlign: TextAlign.center,
              style: GoogleFonts.sora(
                color: Colors.black,
                fontSize: 26
              ),
            )
          ),

          const SizedBox(height: 22,),
          Center(
            child: Text(
              textAlign:TextAlign.center,
              "Take a Photo and Analyse to get the Insights right on the Time.",
              style: GoogleFonts.sora(
                color: Colors.black,
                fontSize: 20
              ),
            )
          )
        ],
      ),
    );
  }
}