import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eko_sortify_app/Changes%20Pages/post_page.dart';
import 'package:eko_sortify_app/Service/authentication/auth_service.dart';
import 'package:eko_sortify_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class DataBaseService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  // save user info
  Future<void> saveUserInfoInFirebase({required String name, email}) async {
    // get current uid
    String uid = _auth.currentUser!.uid;

    // extract username from email
    String username = email.split('@')[0];

    // create a user profile
    UserProfile user = UserProfile(
      uid: uid,
      name: name,
      email: email,
      username: username,
      bio: '',
    );

    // convert user into a map so that we can store in firebase
    final useMap = user.toMap();

    // save user info in firebase
    await _db.collection("Users").doc(uid).set(useMap);
  }

  // Get User Info
  Future<UserProfile?> getUserFromFirebase(String uid) async {
    try {
      // retreive user doc from firebase
      DocumentSnapshot userDoc = await _db.collection("Users").doc(uid).get();

      // convert doc to user profile
      return UserProfile.fromDocument(userDoc);
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// POST MESSAGE

  // post a message
  Future<void> postMessageInFirebase(String messaage) async {
    // get current uid
    try {
      String uid = _auth.currentUser!.uid;

      // use this uid tp get the users profile
      UserProfile? user = await getUserFromFirebase(uid);

      // create a new post
      Post newPost = Post(
          id: '',
          uid: uid,
          name: user!.name,
          username: user.name,
          message: messaage,
          timestamp: Timestamp.now(),
          likeCount: 0,
          likedBy: []
          );

          // convert post object to map
          Map<String, dynamic> newPostMap = newPost.toMap();

          // add to firebase
          await _db.collection("Posts").add(newPostMap); 
    } catch (e) {
      print(e);
    }
  }

  // delete a post
  Future<void> deletePostFromFirebase(String postId) async{
    try{
      await _db.collection("Posts").doc(postId).delete();
    } catch (e){
      print(e);
    }
  }

  // get all post from firebase
  Future<List<Post>> getAllPostsFromFirebase() async{
    try{
      QuerySnapshot snapshot = await _db

        // go to collection -> posts
        .collection("Posts")
        // chronological order
        .orderBy("timestamp", descending: true)
        // get the data
        .get();

        // return a list of post
        return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    } catch (e){
      return [];
    }
  }

  // get induvidial post

  // report user
  Future<void> reportUserInFirebase(String postId, userId) async {
    final currentId = _auth.currentUser!.email;

    final report = {
      'reportedBy': currentId,
      'messageId': postId,
      'messageOwnerId': userId,
      'timeStamp': FieldValue.serverTimestamp(),
    };

    // update in firestore
    await _db.collection("Reports").add(report);
  }

  // update user Bio
  Future<void> updateUserBioFirebase(String bio) async {
    // get current uid
    String uid = AuthService().getCurrentUid();

    // attempt to update in firebase
    try {
      await _db.collection("Users").doc(uid).update({'bio': bio});
    } catch (e) {
      print(e);
    }
  }

  // block user
  Future<void> blockUserInFirebase(String userId) async {
    // get current user id
    final currentuserId = _auth.currentUser!.email;

    // add this user to block list
    await _db
        .collection("Users")
        .doc(currentuserId)
        .collection("BlockedUsers")
        .doc(userId)
        .set({});
  }

  // Unblock User
  Future<void> unblockUserInFirebase(String blockedUserId) async {
    // get current user id
    final currentUserId = _auth.currentUser!.email;

    // unblock in firebase
    await _db
        .collection("Users")
        .doc(currentUserId)
        .collection("BlockedUsers")
        .doc(blockedUserId)
        .delete();
  }

  // get list of blocked user ids
  Future<List<String>> getBlockedUidsFromFirebase() async {
    // get current user id
    final currentUserId = _auth.currentUser!.email;

    // get data of blocked user
    final snapshot = await _db
        .collection("Users")
        .doc(currentUserId)
        .collection("BlockedUsers")
        .get();

    //return as a list of uids
    return snapshot.docs.map((doc) => doc.id).toList();
  }
}
