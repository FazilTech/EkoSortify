import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTile extends StatelessWidget {

  final currentUser = FirebaseAuth.instance.currentUser!;
  final String text;
  final void Function()? onTap;

  UserTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.email)
        .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>?;

            if (userData == null) {
              return Center(
                child: Text(
                  "No user data found.",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              );
            }
        return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Theme.of(context).colorScheme.inversePrimary
            )
          ),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              // profile
              CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
    
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                text,
                style: GoogleFonts.sora(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                ),

                const SizedBox(height: 5,),

                Row(
                  children: [
                    Text(
                "Role",
                style: GoogleFonts.sora(
                  fontSize: 18,
                ),
                ),

                Text(
                "-",
                style: GoogleFonts.sora(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                ),

                

                Text(
                "User",
                style: GoogleFonts.sora(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.secondary
                ),
                ),
                  ],
                )
                ],
              )
            ],
          ),
        ),
      );
      
        }
        else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

      return const Center(
            child: CircularProgressIndicator(),
          );
      
      },
    );
  }
}
