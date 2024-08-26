import 'package:eko_sortify_app/Service/authentication/login_or_register.dart';
import 'package:flutter/material.dart';

import '../Service/authentication/auth_service.dart';
import 'my_drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(){
    final auth = AuthService();
    auth.signOut();
  }
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Image.asset(
              "assets/images/logo.jpeg",
                width: 150,
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Divider(
              color: Color.fromRGBO(59, 200, 100, 10),
            ),
          ),

          MyDrawerTile(
            text: "H O M E", 
            icon: Icons.home, 
            onTap: ()=> Navigator.pop(context),
            ),
          
          const SizedBox(height: 10,),

          MyDrawerTile(
            text: "S E T T I N G S", 
            icon: Icons.settings, 
            onTap: ()=> Navigator.pop(context),
            ),

          const SizedBox(height: 10,),

          MyDrawerTile(
            text: "S U P P O R T", 
            icon: Icons.design_services, 
            onTap: ()=> Navigator.pop(context),
            ),

            const SizedBox(height: 10,),

          MyDrawerTile(
            text: "A B O U T", 
            icon: Icons.person_add, 
            onTap: ()=> Navigator.pop(context),
            ),

          const Spacer(),

          MyDrawerTile(
            text: "L O G  O U T", 
            icon: Icons.logout, 
            onTap: ()=> logout()
            ),

            const SizedBox(height: 20,)
        ],
      ),
    );
  }
}