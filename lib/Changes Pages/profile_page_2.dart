import 'package:eko_sortify_app/Components/my_bio_box.dart';
import 'package:eko_sortify_app/Components/my_input_alert_box.dart';
import 'package:eko_sortify_app/Components/my_post_tile.dart';
import 'package:eko_sortify_app/Service/authentication/auth_service.dart';
import 'package:eko_sortify_app/Service/authentication/database_provider.dart';
import 'package:eko_sortify_app/helper/navigate_pages.dart';
import 'package:eko_sortify_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage2 extends StatefulWidget {
  const ProfilePage2({
    super.key,
    required this.uid
    });

  // user id
  final String uid;

  @override
  State<ProfilePage2> createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {

  // providers
  late final listeningProvider= Provider.of<DatabaseProvider>(context);
  late final databaseProvider = 
    Provider.of<DatabaseProvider>(context, listen: false);

  // user info
  UserProfile? user;
  String currentUserId = AuthService().getCurrentUid();

  final bioController = TextEditingController();

  // loading 
  bool _isLoading = true;

  // on startup
  @override
  void initState() {
    super.initState();

    loadUser();
  }

  Future<void> loadUser() async{
    // get the user profile info
    user = await databaseProvider.userProfile(widget.uid);
    
    // final loading
    setState(() {
      _isLoading = false;
    });
  }

  void _showEditBioBox(){
    showDialog(
      context: context, 
      builder: (context) => MyInputAlertBox(
        textController: bioController, 
        hintText: "Edit Text", 
        onTap: saveBio, 
        onPressedText: "Save"
        )
      );
  }

  // save update bio
  Future<void> saveBio() async{
    setState(() {
      _isLoading = true;
    });

    // update bio
    await databaseProvider.updateBio(bioController.text);

    // reload user
    await loadUser();

    // done loading...
    setState(() {
      _isLoading = false;
    });

    print("Saving...");
  }

  @override
  Widget build(BuildContext context) {

    // get user posts
    final allUserPosts = listeningProvider.filterUserPosts(widget.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLoading? '' : user!.name
        ),
      ),

      body: ListView(
        children: [
          // user handle
          Center(
            child: Text(
              _isLoading ? '' : '@${user!.username}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary
              ),
            ),
          ),
      
          const SizedBox(height: 25,),
      
          // profile picture
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(25)
              ),
              padding: const EdgeInsets.all(25),
              child: Icon(
                Icons.person,
                size: 72,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
          ),
      
          const SizedBox(height: 25,),
      
          // priofite state -> number of posts / followers / following
          
      
          // follow / unfollow button
      
          // edit bio
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bio",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
                GestureDetector(
                  onTap: _showEditBioBox,
                  child: Icon(Icons.settings)
                  )
              ],
            ),
          ),
      
          // bio box
          MyBioBox(
            text: _isLoading? '...' : user!.bio
            ),

          Padding(
            padding: const EdgeInsets.only(left: 25, top: 20),
            child: Text(
              "Posts",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary
              ),
            ),
          ),
      
          // list of posts from user
          allUserPosts.isEmpty?

          // user post is empty
          const Center(child: Text("No Post Yet..."),)

          :

          // user post is not empty
          ListView.builder(
            itemCount: allUserPosts.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // get induvidal post
              final post = allUserPosts[index];

              // post tile UI
              return MyPostTile(
                post: post,
                onUserTap: (){},
                onPostTap: () => goPostPage(context, post),
                );
            },
            )
        ],
      ),
    );
  }
}