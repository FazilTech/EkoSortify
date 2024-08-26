import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 100),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Lottie.asset("assets/animation/Animation3.json"),
          ),

          const SizedBox(height: 80,),
          Center(
            child: Text(
              "Sort the Products",
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
              "Sort all the products as a Recycle and \nNon-recycle Products.",
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