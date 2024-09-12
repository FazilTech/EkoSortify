import 'dart:convert'; 
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eko_sortify_app/Components/my_drawer.dart';
import 'package:eko_sortify_app/Pages/Post_page.dart';
import 'package:eko_sortify_app/Pages/Sorting%20Button/sorting_page.dart';
import 'package:eko_sortify_app/Pages/chat_page.dart';
import 'package:eko_sortify_app/Pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eko_sortify_app/Pages/chatbot_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? _detectionResult;

  void onProfileTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  final currentUser = FirebaseAuth.instance.currentUser!;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Function to open the camera and capture a photo
  Future<void> _capturePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // Upload the image and get detection results
      try {
        final result = await _uploadImage(_image!);
        setState(() {
          _detectionResult = result;
        });
      } catch (e) {
        print('Error during image upload: $e');
        setState(() {
          _detectionResult = 'Error: $e';
        });
      }

      // Display a dialog or any other widget to show the captured image and detection result
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Captured Image"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _image != null ? Image.file(_image!) : Text("No image selected."),
              if (_detectionResult != null)
                Text("Detection Result: $_detectionResult"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  // Function to upload the image to your backend
  Future<String?> _uploadImage(File image) async {
    // Replace with your actual backend IP (Flask app running on a server or in the cloud)
    final uri = Uri.parse('http://192.168.116.132:5000/detect'); 
    final request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Response Body: $responseBody');
        final data = jsonDecode(responseBody);
        return data['bottle_detected'] == true ? 'Bottle Detected' : 'No Bottle Detected';
      } else {
        print('Failed to upload image. Status Code: ${response.statusCode}');
        return 'Failed to upload image';
      }
    } catch (e) {
      print('Error during image upload: $e');
      return 'Error during image upload';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        onProfileTap: onProfileTap,
        onSignOutTap: signOut,
      ),
      key: _scaffoldKey,
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 10,
            right: 1,
            child: FloatingActionButton(
              backgroundColor: Color.fromRGBO(59, 200, 100, 30),
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              child: Icon(Icons.android),
            ),
          ),
          Positioned(
            bottom: 90,
            right: 1,
            child: FloatingActionButton(
              backgroundColor: Color.fromRGBO(59, 200, 100, 30),
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
              child: Icon(Icons.message),
            ),
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data?.data() == null) {
            return Center(child: Text("No user data found."));
          } else {
            final userData = snapshot.data!.data() as Map<String, dynamic>?;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 60, bottom: 35),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(59, 200, 100, 30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    _scaffoldKey.currentState?.openDrawer();
                                  },
                                  icon: Icon(Icons.dashboard_rounded),
                                ),
                                fillColor: Colors.green,
                                border: InputBorder.none,
                                hintText: "Search Anything...",
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.search),
                                      onPressed: () {
                                        // Handle search icon tap
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      onPressed: _capturePhoto,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "WELCOME,",
                                    style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 1),
                                  child: Text(
                                    userData!['username'],
                                    style: GoogleFonts.sora(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Text(
                                        "Level 0",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.eco),
                                          Text(
                                            "0 Points",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            CircleAvatar(
                              radius: 65,
                              backgroundImage:
                                  userData['profileImageUrl'] != null
                                      ? NetworkImage(
                                          userData['profileImageUrl'])
                                      : const AssetImage(
                                              'assets/images/logo.jpeg')
                                          as ImageProvider, // Placeholder image
                              backgroundColor: Colors.grey[200],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Learn More about Sorting and Recycling",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sora(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SortingPage(),
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 60),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Text(
                            "Sorting",
                            style: GoogleFonts.sora(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        padding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: 50),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)),
                        child: Text(
                          "Recycling",
                          style: GoogleFonts.sora(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Explore more on the \nCommunity",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sora(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 15),
                  MaterialButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PostPage(),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: 155),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),
                      child: Text(
                        "Click",
                        style: GoogleFonts.sora(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 180),
                  Text(
                    "Logged in as: " + currentUser.email!,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
