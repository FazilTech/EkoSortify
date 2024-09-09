import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eko_sortify_app/Components/text_field.dart';
import 'package:eko_sortify_app/Components/wall_post.dart';
import 'package:eko_sortify_app/Pages/profile_page.dart';
import 'package:eko_sortify_app/helper/helper_methord.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void postMessage() {
    // Only post if there's content in the textField
    if (textController.text.isNotEmpty) {
      // Store in Firebase
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimesStamp': Timestamp.now(),
        'uid': currentUser.uid, 
        'Likes': [],
        'Comments': []
      });
    }

    // Clear the text
    setState(() {
      textController.clear();
    });
  }

  void goToProfilePage(){
    Navigator.pop(context);

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => const ProfilePage()
      ));
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
         
        title: const Padding(
          padding: EdgeInsets.only(left: 90),
          child: Text("Eko Sortify"),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("User Posts")
                    .orderBy("TimesStamp", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }

                  if (snapshot.hasData) {
                    final posts = snapshot.data!.docs;
                    if (posts.isEmpty) {
                      return const Center(
                        child: Text("No posts yet, be the first to post!"),
                      );
                    }

                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return WallPost(
                          message: post['Message'],
                          user: post['UserEmail'],
                          postId: post.id,
                          likes: post['Likes'] != null
                              ? List<String>.from(post['Likes'])
                              : [],
                          time: formatDate(post['TimesStamp'])
                        );
                      },
                    );
                  }

                  return const Center(
                    child: Text("Something went wrong."),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 1, left: 5, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: "Share all the Exiting stuffs you do..",
                      obsureText: false,
                    ),
                  ),
                  IconButton(
                    onPressed: postMessage,
                    icon: Icon(
                      Icons.arrow_circle_up,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      size: 35,
                      ),
                  )
                ],
              ),
            ),
            Text(
              "Logged in as: " + currentUser.email!,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}