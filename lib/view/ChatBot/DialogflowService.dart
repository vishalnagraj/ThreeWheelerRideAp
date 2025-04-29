// lib/view/ChatBot/DialogflowService.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

class DialogflowService {
  final String _projectId = 'YOUR_PROJECT_ID'; // Replace with your Dialogflow project ID
  final String _sessionId = 'YOUR_SESSION_ID'; // Replace with your Dialogflow session ID
  final String _languageCode = 'en'; // Language code

  // Replace with your Dialogflow API key
  final String _apiKey = 'YOUR_API_KEY'; // Replace with your Dialogflow API key

  Future<String> sendMessage(String message) async {
    final url = Uri.parse('https://dialogflow.googleapis.com/v2/projects/$_projectId/agent/sessions/$_sessionId:detectIntent?key=$_apiKey');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "queryInput": {
          "text": {
            "text": message,
            "languageCode": _languageCode,
          }
        }
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['queryResult']['fulfillmentText']; // Adjust based on Dialogflow's response structure
    } else {
      throw Exception('Failed to communicate with Dialogflow');
    }
  }
}
