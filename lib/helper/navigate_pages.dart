// go to user page
import 'package:eko_sortify_app/Changes%20Pages/post_page.dart';
import 'package:eko_sortify_app/Changes%20Pages/post_pagew.dart';
import 'package:eko_sortify_app/Changes%20Pages/profile_page_2.dart';
import 'package:flutter/material.dart';

void goUserPage(BuildContext context, String uid) {
  // navigate to the maps
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage2(uid: uid),
      ));
}

// go to post page
void goPostPage(BuildContext context, Post post) {
  // navigate to post page
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostPage2(
          post: post,
        ),
      ));
}
