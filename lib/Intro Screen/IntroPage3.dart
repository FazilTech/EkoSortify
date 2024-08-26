import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 100),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Lottie.asset("assets/animation/Animation 1.json"),
          ),

          const SizedBox(height: 18,),
          Center(
            child: Text(
              "Strong Community",
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
              "Build a Strong Community and make eveyone of them do the process to make the world better.",
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