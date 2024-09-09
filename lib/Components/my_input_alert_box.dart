import 'package:flutter/material.dart';

class MyInputAlertBox extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final void Function()? onTap;
  final String onPressedText;
  
  const MyInputAlertBox({
    super.key,
    required this.textController,
    required this.hintText,
    required this.onTap,
    required this.onPressedText
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0)
        )
      ),

      content: TextField(
        controller: textController,

        maxLength: 140,
        maxLines: 3,

        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.inversePrimary,
              
            ),
            borderRadius: BorderRadius.circular(12)
          ),

          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary
          ),

          // color inside of textField
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true
        ),
      ),

      backgroundColor: Theme.of(context).colorScheme.secondary,

      actions: [
        // cancel button
        TextButton(
          onPressed: (){
            Navigator.pop(context);

            textController.clear();
          }, 
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary
            ),
          )
          ),

          // yes button
          TextButton(
            onPressed: (){
              Navigator.pop(context);

              onTap!();

              textController.clear();
            }, 
            child: Text(
              onPressedText,
              style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary
            ),
              ),
            ),
      ],
    );
  }
}