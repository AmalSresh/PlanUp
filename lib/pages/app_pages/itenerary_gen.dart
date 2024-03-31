import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GenPage extends StatefulWidget {
  const GenPage({Key? key}) : super(key: key); // Added a named key parameter

  @override
  _GenPageState createState() => _GenPageState();
}

class _GenPageState extends State<GenPage> {
  String _response = 'Response will appear here';

  Future<void> makeOpenAIAPIRequest(String apiKey) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    };

    final body = json.encode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content": "You are a super helpful travel planner..."
        },
        {
          "role": "user",
          "content": "Location: {location} mile radius {mile}..."
        }
      ]
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      setState(() {
        _response = response.body;
      });
    } else {
      setState(() {
        _response = 'Error: ${response.body}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenAI API Demo'), // Use const
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => makeOpenAIAPIRequest('YOUR_API_KEY'),
              child: const Text('Generate'), // Use const
            ),
            const SizedBox(height: 20), // Use const
            Text(_response),
          ],
        ),
      ),
    );
  }
}
