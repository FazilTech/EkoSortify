import 'package:eko_sortify_app/Components/my_list_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOutTap;
  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onSignOutTap
    });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Column(
              children: [

              DrawerHeader(
              child: Image.asset(
                "assets/images/logo-b.png",
                color: Colors.white,
                )
            ),
              
              MyListTile(
              icon: Icons.home, 
              text: 'H O M E',
              onTap: ()=> Navigator.pop(context),
              ),

            MyListTile(
              icon: Icons.person, 
              text: 'P R O F I L E', 
              onTap: onProfileTap
              ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: MyListTile(
                icon: Icons.logout, 
                text: 'L O G  O U T', 
                onTap: onSignOutTap
                ),
            ),
        ],
      ),
    );
  }
}