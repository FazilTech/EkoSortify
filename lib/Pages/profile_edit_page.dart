import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eko_sortify_app/Components/text_box.dart';
import 'package:eko_sortify_app/Service/storage/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  // Current user
  final currentUser = FirebaseAuth.instance.currentUser!;
  
  // Firestore collection reference
  final userCollection = FirebaseFirestore.instance.collection("Users");

  // Profile image URL
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();

    // Fetch images when the page is initialized
    fetchImages();
  }

  // Fetch images from the StorageService
  Future<void> fetchImages() async {
    await Provider.of<StorageService>(context, listen: false).fetchImages();
  }

  // Edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // Save button
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    // Update in Firestore if the new value is not empty
    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  // Select and upload profile image
  Future<void> selectAndUploadProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return; // User canceled the picker

    final File file = File(image.path);

    try {
      // Define the path in storage
      final String filePath = 'profile_images/${currentUser.email}.png';

      // Upload the file to Firebase Storage
      await FirebaseStorage.instance.ref(filePath).putFile(file);

      // Get the download URL
      final String downloadUrl = await FirebaseStorage.instance.ref(filePath).getDownloadURL();

      // Update the profile image URL in Firestore
      await userCollection.doc(currentUser.email).update({'profileImageUrl': downloadUrl});

      // Update local state
      setState(() {
        profileImageUrl = downloadUrl;
      });
    } catch (e) {
      print("Error uploading profile image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Edit the Profile"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: userCollection.doc(currentUser.email).snapshots(),
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

            profileImageUrl = userData['profileImageUrl'];

            return ListView(
              children: [
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Center(
                    child: Text(
                      "My Details",
                      style: GoogleFonts.sora(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.tertiary
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20,),

                // Profile Image Section
                Center(
                  child: GestureDetector(
                    onTap: selectAndUploadProfileImage,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: profileImageUrl != null
                          ? NetworkImage(profileImageUrl!)
                          : const AssetImage('assets/images/logo.jpeg') as ImageProvider,
                      child: profileImageUrl == null
                          ? Icon(
                              Icons.add_a_photo,
                              size: 20,
                              color: Colors.white,
                            )
                          : null,
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                MyTextBox(
                  text: userData['username'] ?? 'No username',
                  sectionName: 'Username',
                  onPressed: () => editField('username'),
                ),
                MyTextBox(
                  text: userData['bio'] ?? 'No bio',
                  sectionName: 'Bio',
                  onPressed: () => editField('bio'),
                ),
                MyTextBox(
                  text: userData['city'] ?? 'No city',
                  sectionName: 'City',
                  onPressed: () => editField('city'),
                ),
                MyTextBox(
                  text: userData['country'] ?? 'No country',
                  sectionName: 'Country',
                  onPressed: () => editField('country'),
                ),
                const SizedBox(height: 50),
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
