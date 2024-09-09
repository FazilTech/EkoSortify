import 'package:eko_sortify_app/Changes%20Pages/post_page.dart';
import 'package:eko_sortify_app/Service/authentication/database_service.dart';
import 'package:eko_sortify_app/models/user.dart';
import 'package:flutter/material.dart';

class DatabaseProvider extends ChangeNotifier{

  final _db = DataBaseService();

  // USER PROFILE

  // get user profile given uid
  Future<UserProfile?> userProfile(String uid) => _db.getUserFromFirebase(uid);

  // update user bio
  Future<void> updateBio(String bio) => _db.updateUserBioFirebase(bio);

  /// POST
  
  // local list of posts
  List<Post> _allPosts = [];

  // get posts
  List<Post> get allPosts => _allPosts;

  // post message
  Future<void> postMessage(String message) async{
    // post message to firebase
    await _db.postMessageInFirebase(message);

    // reload data from firebase
    await loadAllPosts();
  }

  // fetch all post
  Future<void> loadAllPosts() async{
    // get all post from firebase
    final allPosts = await _db.getAllPostsFromFirebase();

    // update local data
    _allPosts = allPosts;

    // update UI
    notifyListeners();
  }

  // filter and return posts given uid
  List<Post> filterUserPosts(String uid){
    return _allPosts.where((post) => post.uid == uid).toList();
  }

  // delete post
  Future<void> deletePost(String postId) async{
    // delete from firebase
    await _db.deletePostFromFirebase(postId);

    // reload data from firebase
    await loadAllPosts();
  }

  // get all posts
  // Future<List<Post>>

  // /AcCOUNT STUFF///

  // local list of blocked users
  List<UserProfile> _blockedUsers = [];

  // get list of blocked users
  List<UserProfile> get blockedUsers => _blockedUsers;

  // fetch blocked users
  Future<void> loadBlockedUser() async{
    // get the list of blocked user ids
    final blockedUserIds = await _db.getBlockedUidsFromFirebase();

    // get full user details using uid
    final blockedUsersData = await Future.wait(
      blockedUserIds.map((id) => _db.getUserFromFirebase(id))
    );

    // return as a list
    _blockedUsers = blockedUsersData.whereType<UserProfile>().toList();

    // update Ui
    notifyListeners();
  }
   
  // block user
  Future<void> blockUser(String userId) async{
    // perform block in firebase
    await _db.blockUserInFirebase(userId);

    // reload data
    
  }

  // unblock user

  // report user and post
}