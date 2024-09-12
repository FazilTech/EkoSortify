import 'package:eko_sortify_app/Service/chatbot/chatbot_service.dart';
import 'package:flutter/material.dart';
import 'package:eko_sortify_app/models/messages.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ChatbotService _chatbotService = ChatbotService();
  
  // A list to store messages
  List<Message> _messages = [];

  // Send a message
  void _sendMessage() async {
    final userMessage = _controller.text.trim();

    if (userMessage.isNotEmpty) {
      setState(() {
        _messages.add(Message(text: userMessage, isUserMessage: true));
      });
      _controller.clear(); // Clear the input field

      try {
        final botResponse = await _chatbotService.getBotResponse(userMessage);
        setState(() {
          _messages.add(Message(text: botResponse, isUserMessage: false));
        });
      } catch (error) {
        setState(() {
          _messages.add(Message(text: "Error: Unable to connect to chatbot.", isUserMessage: false));
        });
      }
    }
  }

  // Build the chat bubbles
  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: message.isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: message.isUserMessage ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message.text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Bot'),
      ),
      body: Column(
        children: [
          // Display the list of messages
          Expanded(
            child: ListView.builder(
              reverse: true, // New messages appear at the bottom
              padding: EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[_messages.length - 1 - index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
