import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Comment extends StatelessWidget {
  final String user;
  final String text;
  final String time;
  const Comment({
    super.key,
    required this.text,
    required this.user,
    required this.time
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // comment
          Text(
            text,
            style: GoogleFonts.sora(
              fontSize: 15
            ),
            ),

          const SizedBox(height: 5,),

          // user and time
          Row(
            children: [
              Text(
                user,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background
                ),
                ),
              Text(
                " . ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background
                ),
                ),
              Text(
                time,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background
                ),
                )
            ],
          )
        ],
      ),
    );
  }
}