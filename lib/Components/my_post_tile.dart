import 'package:eko_sortify_app/Changes%20Pages/post_page.dart';
import 'package:eko_sortify_app/Service/authentication/auth_service.dart';
import 'package:flutter/material.dart';

class MyPostTile extends StatefulWidget {
  final Post post;
  final void Function()? onUserTap;
  final void Function()? onPostTap;

  const MyPostTile({
    super.key,
    required this.post,
    required this.onUserTap,
    required this.onPostTap,
    });

  @override
  State<MyPostTile> createState() => _MyPostTileState();
}

class _MyPostTileState extends State<MyPostTile> {

  void _showOptons(){

    // check if the post is owned by the user or not
    String currentUid = AuthService().getCurrentUid();
    final bool isOwnPost = widget.post.uid == currentUid;

    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [

              // this post belogs to 
            if(isOwnPost)

              // delete message button
              ListTile(
                leading: const Icon(Icons.delete),
                onTap: (){},
                title: Text("Delete"),
              )

              else ...{
                // report post button
                ListTile(
                leading: const Icon(Icons.flag),
                onTap: (){},
                title: Text("Report"),
              ),

                // block user button
                ListTile(
                leading: const Icon(Icons.block),
                onTap: (){},
                title: Text("Block User"),
              ),
              },
        
              // cancel message button
              ListTile(
                leading: const Icon(Icons.cancel),
                onTap: (){},
                title: Text("Cencel"),
              ),
            ],
          ),
        );
      },
      );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPostTap,
      child: Container(
    
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    
        padding:  EdgeInsets.all(20),
    
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
    
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: widget.onUserTap,
              child: Row(
                children: [
            
                  // profile pic
                  Icon(Icons.person, color: Theme.of(context).colorScheme.secondary,),
            
                  Text(
                    widget.post.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold
                    ),
                  ),
            
                  // username handle
                  Text(
                    "@${widget.post.username}", style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                    ),
                  ),

                  Spacer(),
            
                  // button -> more options
                  GestureDetector(
                    onTap: _showOptons,
                    child: Icon(Icons.more_horiz)
                    )
                ],
              ),
            ),
    
            const SizedBox(height: 4,),
            
            Text(
              widget.post.message, 
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary
              ),
            )
          ],
        ),
        
      ),
    );
  }
}