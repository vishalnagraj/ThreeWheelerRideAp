import 'package:flutter/material.dart';
import 'dart:async';

// Import the ChatBotData class
import 'ChatBotData.dart'; // Ensure this is correctly imported

class ChatBotPage extends StatefulWidget {
  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  final List<String> _initialOptions = [
    'What is Threewheeler concept?',
    'How do I book a ride?',
    'What is the payment method?',
    'What is the cancellation policy?',
    'How can I contact customer support?',
    'What are the operating hours?'
  ];

  @override
  void initState() {
    super.initState();
    // Initial message to greet the user
    _messages.add({
      'sender': 'bot',
      'message': 'Hello! How can I assist you today? Please choose an option below:',
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      String userInput = _controller.text.trim();
      setState(() {
        _messages.add({'sender': 'user', 'message': userInput});
      });

      Timer(Duration(seconds: 1), () {
        setState(() {
          String botResponse = _getBotResponse(userInput);
          _messages.add({'sender': 'bot', 'message': botResponse});
        });
      });

      _controller.clear();
    }
  }

  String _getBotResponse(String userInput) {
    // Check if the input exists in ChatBotData's map, else return default message
    String response = ChatBotData.qaMap[userInput] ??
        'I\'m sorry, I didn\'t understand that. Please choose an option from the list.';
    return response;
  }

  void _handleOptionClick(String option) {
    setState(() {
      // Clear previous messages when a new option is selected
      _messages.clear();
      _messages.add({'sender': 'user', 'message': option});
    });

    Timer(Duration(seconds: 1), () {
      setState(() {
        String botResponse = _getBotResponse(option);
        _messages.add({'sender': 'bot', 'message': botResponse});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Bot'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final bool isUserMessage = message['sender'] == 'user';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message['message']!,
                        style: TextStyle(color: isUserMessage ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Show options when no previous message or only bot's message is present
          if (_messages.isEmpty || _messages.last['sender'] == 'bot')
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: _initialOptions.map((option) {
                  return ElevatedButton(
                    onPressed: () => _handleOptionClick(option),
                    child: Text(option),
                  );
                }).toList(),
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
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
