import 'package:flutter/material.dart';

class MyBioBox extends StatelessWidget {

  final String text;

  const MyBioBox({
    super.key,
    required this.text
    });

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(horizontal: 25),

      padding: EdgeInsets.all(25),
      
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        
        borderRadius: BorderRadius.circular(8)
      ),

      child: Text(
        text.isNotEmpty? text : 'Empty Bio...',
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary
        ),
      ),
    );
  }
}