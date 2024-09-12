import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotService {
  final String apiUrl = "http://192.168.116.132:5000/chat";

  Future<String> getBotResponse(String message) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"message": message}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse["response"];
    } else {
      throw Exception("Failed to connect to chatbot");
    }
  }
}
