import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eko_sortify_app/Pages/Home.dart';
import 'package:eko_sortify_app/Pages/profile_edit_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // User
  final currentUser = FirebaseAuth.instance.currentUser!;
  
  // Firestore collection reference
  final userCollection = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder<DocumentSnapshot>(
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

            return ListView(
              children: [
                const SizedBox(height: 10,),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: ()=> Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => const Home(),)),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(right: 25),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(                  
                  children: [
                    // Profile Image
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CircleAvatar(
                        radius: 80, 
                        backgroundImage: userData['profileImageUrl'] != null
                            ? NetworkImage(userData['profileImageUrl'])
                            : const AssetImage('assets/images/logo.jpeg') as ImageProvider, // Placeholder image
                        backgroundColor: Colors.grey[200], 
                        
                      ),
                    ),

                    const SizedBox(width: 20,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                      children: [
                        Text(
                          userData['username'] ?? 'No username',
                          style: GoogleFonts.sora(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        const SizedBox(height: 4,),

                        Row(
                          children: [
                            Text(
                              userData['city'] ?? 'No city',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600]
                              ),
                            ),
                            Text(
                              ', ',
                              style: TextStyle(
                                fontSize: 20
                              ),
                            ),
                            Text(
                              userData['country'] ?? 'No country',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600]
                              ),
                            ),

                          ],
                        ),

                        const SizedBox(height: 4,),

                        Row(
                          children: [
                            Text(
                              'Role',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black
                              ),
                            ),
                            Text(
                              ' - ',
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                            Text(
                              "User",
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 7),

                        Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "0",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                        fontSize: 15
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(width: 10,),

                                Column(
                                  children: [
                                    Text(
                                      "0",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      "Following",
                                      style: TextStyle(
                                        fontSize: 15
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                        
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    MaterialButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileEditPage(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        child: Text(
                          "Edit Profile",
                          style: GoogleFonts.sora(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Text(
                        "Share Profile",
                        style: GoogleFonts.sora(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    "My Posts",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
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
      ),
    );
  }
}
