import 'package:eko_sortify_app/Theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentuser;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentuser,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isCurrentuser
         ?(isDarkMode ?Colors.green.shade600 : Theme.of(context).colorScheme.primary)
         :(isDarkMode ?Colors.grey.shade900 : Colors.grey.shade200),  
          borderRadius: BorderRadius.circular(12),
     
         ),
        
      padding: EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      child: Text(
        message,
        style: TextStyle(color: isDarkMode 
        ? Colors.white :(isDarkMode ? Colors.white : Colors.black)),
      ),
    );
  }
}
