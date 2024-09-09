import 'package:eko_sortify_app/Changes%20Pages/post_page.dart';
import 'package:eko_sortify_app/Changes%20Pages/profile_page_2.dart';
import 'package:eko_sortify_app/Components/my_drawer.dart';
import 'package:eko_sortify_app/Components/my_input_alert_box.dart';
import 'package:eko_sortify_app/Components/my_post_tile.dart';
import 'package:eko_sortify_app/Service/authentication/auth_service.dart';
import 'package:eko_sortify_app/Service/authentication/database_provider.dart';
import 'package:eko_sortify_app/helper/navigate_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomenPage extends StatefulWidget {
  const HomenPage({super.key});

  @override
  State<HomenPage> createState() => _HomenPageState();
}

class _HomenPageState extends State<HomenPage> {

  late final databaseProvider = 
    Provider.of<DatabaseProvider>(context, listen: false);

  late final listenProvider = Provider.of<DatabaseProvider>(context);

  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // lets load all process
    loadAllPosts();
  }

  Future<void> loadAllPosts() async{
    await databaseProvider.loadAllPosts();
  }

  // show post message dialog box
  void _openPostMessageBox() {
    showDialog(
        context: context,
        builder: (context) => MyInputAlertBox(
            textController: _messageController,
            hintText: "What do you want to convert",
            onTap: () async{
              await postMessage(_messageController.text);
            },
            onPressedText: "Post"
            )
            );
  }

  // user wants to Post Message
  Future<void> postMessage(String message) async{
    await databaseProvider.postMessage(message);
  }


  final AuthService _auth = AuthService();

  void onProfileTap() {
    final String? uid = _auth.getCurrentUid();
    if (uid != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage2(uid: uid)),
      );
    } else {
      // Handle the case where the UID is null (e.g., show an error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("My Home Page"),
      ),
      drawer: MyDrawer(
        onProfileTap: () => onProfileTap(),
        onSignOutTap: () => _auth.signOut(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openPostMessageBox,
        child: const Icon(Icons.add),
      ),

      body: _buildPostList(listenProvider.allPosts),
    );
  }

  // build list UI given as list of posts
  Widget _buildPostList(List<Post> posts){
    return posts.isEmpty? Center(
      child: Text(
        "Nothing Here..."
      ),
    )
    :
    ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        // get each induvidial post
        final post = posts[index];

        // return Post tile UI
        return MyPostTile(
          post: post,
          onUserTap: () => goUserPage(context, post.uid),
          onPostTap: () => goPostPage(context, post),
          );
    },
    );
  }
}
