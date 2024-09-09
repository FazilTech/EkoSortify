import 'package:eko_sortify_app/Changes%20Pages/post_page.dart';
import 'package:eko_sortify_app/Components/my_post_tile.dart';
import 'package:eko_sortify_app/helper/navigate_pages.dart';
import 'package:flutter/material.dart';

class PostPage2 extends StatefulWidget {
  final Post post;

  const PostPage2({super.key, required this.post});

  @override
  State<PostPage2> createState() => _PostPage2State();
}

class _PostPage2State extends State<PostPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
      ),
      body: ListView(
        children: [
          // Post
          MyPostTile(
            post: widget.post, 
            onUserTap: ()=> goUserPage(context, widget.post.uid), 
            onPostTap: (){}
            ),
        ],
      ),
    );
  }
}
