//import 'package:eko_sortify_app/Pages/Home.dart';
import 'package:eko_sortify_app/Changes Pages/homen.dart';
import 'package:eko_sortify_app/Pages/Home.dart';
import 'package:eko_sortify_app/Service/authentication/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eko_sortify_app/Intro Screen/Spalash_Screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if(snapshot.hasData){
            return const Home();
            //return const Homen();
          }
          else{
            return const LoginOrRegister();
          }
        }
        


        )
        ),
    );
  }
}