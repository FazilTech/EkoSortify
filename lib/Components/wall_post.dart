import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eko_sortify_app/Components/comment_button.dart';
import 'package:eko_sortify_app/Components/comments.dart';
import 'package:eko_sortify_app/Components/delete_button.dart';
import 'package:eko_sortify_app/Components/like_button.dart';
import 'package:eko_sortify_app/helper/helper_methord.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  final String time;

  const WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    required this.time,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  // User
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  // Track whether comments are shown or hidden
  bool areCommentsVisible = false;

  // comments text controller
  final _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLikes() {
    setState(() {
      isLiked = !isLiked;
      // Update the 'Likes' field in Firestore accordingly
      if (isLiked) {
        FirebaseFirestore.instance
            .collection("User Posts")
            .doc(widget.postId)
            .update({
          'Likes': FieldValue.arrayUnion([currentUser.email]),
        });
      } else {
        FirebaseFirestore.instance
            .collection("User Posts")
            .doc(widget.postId)
            .update({
          'Likes': FieldValue.arrayRemove([currentUser.email]),
        });
      }
    });
  }

  // add a comment
  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now(),
    });
  }

  // show a dialog box for adding comment
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Comment"),
        content: TextField(
          controller: _commentTextController,
          decoration: InputDecoration(hintText: "Write a comment.."),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _commentTextController.clear();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              addComment(_commentTextController.text);
              Navigator.pop(context);
              _commentTextController.clear();
            },
            child: Text("Post"),
          ),
        ],
      ),
    );
  }

  // delete a post
  void deletePost() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Post"),
        content: const Text("Are you sure you want to delete the post?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final commentDocs = await FirebaseFirestore.instance
                  .collection("User Posts")
                  .doc(widget.postId)
                  .collection("Comments")
                  .get();

              for (var doc in commentDocs.docs) {
                await FirebaseFirestore.instance
                    .collection("User Posts")
                    .doc(widget.postId)
                    .collection("Comments")
                    .doc(doc.id)
                    .delete();
              }

              FirebaseFirestore.instance
                  .collection("User Posts")
                  .doc(widget.postId)
                  .delete()
                  .then((value) => print("Post Deleted"))
                  .catchError((error) =>
                      print("Failed to delete the post: $error"));

              Navigator.pop(context);
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  // Toggle comments visibility
  void toggleCommentsVisibility() {
    setState(() {
      areCommentsVisible = !areCommentsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wallpost
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.message,
                      style: GoogleFonts.sora(
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis, // Handle overflow
                      maxLines: 3, // Limit number of lines
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          widget.user,
                          style: GoogleFonts.sora(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          " . ",
                          style: GoogleFonts.sora(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                        Text(
                          widget.time,
                          style: GoogleFonts.sora(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (widget.user == currentUser.email)
                DeleteButton(onTap: deletePost),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      LikeButton(
                        isLiked: isLiked,
                        onTap: toggleLikes,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.likes.length.toString(),
                        style: GoogleFonts.sora(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      CommentButton(onTap: showCommentDialog),
                      const SizedBox(height: 5),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("User Posts")
                            .doc(widget.postId)
                            .collection("Comments")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text(
                              "0",
                              style: GoogleFonts.sora(
                                color:
                                    Theme.of(context).colorScheme.inversePrimary,
                              ),
                            );
                          }

                          int commentCount = snapshot.data!.docs.length;

                          return Text(
                            commentCount.toString(),
                            style: GoogleFonts.sora(
                              color: Theme.of(context).colorScheme.inversePrimary,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      Icon(Icons.send),
                      const SizedBox(height: 5),
                      Text(
                        "*",
                        style: GoogleFonts.sora(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: toggleCommentsVisibility,
                child: Text(
                  areCommentsVisible ? 'Hide Comments' : 'Show Comments',
                  style: GoogleFonts.sora(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (areCommentsVisible)
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .doc(widget.postId)
                  .collection("Comments")
                  .orderBy("CommentTime", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc) {
                    final commentData =
                        doc.data() as Map<String, dynamic>;

                    return Comment(
                      text: commentData["CommentText"],
                      user: commentData["CommentedBy"],
                      time: formatDate(commentData["CommentTime"]),
                    );
                  }).toList(),
                );
              },
            ),
        ],
      ),
    );
  }
}
