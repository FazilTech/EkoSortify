import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CentersPage extends StatefulWidget {
  const CentersPage({super.key});

  @override
  State<CentersPage> createState() => _CentersPageState();
}

class _CentersPageState extends State<CentersPage> {

  FirebaseAuth _auth = FirebaseAuth.instance;

  void signout(){
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Text(
          "Location Page"
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: ()=> signout(), 
            icon: Icon(Icons.logout)
            )
        ],
      ),
    );
  }
}