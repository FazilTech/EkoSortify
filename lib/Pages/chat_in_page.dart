import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eko_sortify_app/Components/chat_bubble.dart';
import 'package:eko_sortify_app/Components/text_field.dart';
import 'package:eko_sortify_app/Service/authentication/auth_service.dart';
import 'package:eko_sortify_app/Service/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatinPage extends StatelessWidget {
  final String receiveEmail;
  final String receiverID;

  ChatinPage({
    super.key,
    required this.receiveEmail,
    required this.receiverID,
  });

  // Text controller
  final TextEditingController _messageCOntroller = TextEditingController();

  // Chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // Send message
  void sendMessage() async {
    if (_messageCOntroller.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageCOntroller.text);

      // Clear text controller
      _messageCOntroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(receiveEmail),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Display messages
          Expanded(
            child: _buildMessageList(),
          ),

          // User input
          _buildUserInput(),
        ],
      ),
    );
  }

  // Build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()?.uid ?? '';

    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading....");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  // Build individual message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      return const SizedBox.shrink(); // Return an empty widget if data is null
    }

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()?.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data["message"] ?? '', // Fallback empty string if null
            isCurrentuser: isCurrentUser,
          ),
        ],
      ),
    );
  }

  // Build user input field
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageCOntroller,
              hintText: "Type a message",
              obsureText: false,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward),
            ),
          )
        ],
      ),
    );
  }
}
