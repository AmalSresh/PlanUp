import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';

import 'env.dart';

Future<List<String>> rec(var value, var values) async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.KEY;

  // Start using!
  final systemMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "return any message you are given as JSON.",
      ),
    ],
    role: OpenAIChatMessageRole.assistant,
  );

  // the user message that will be sent to the request.
  final userMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "$value",
      ),
    ],
    role: OpenAIChatMessageRole.user,
  );

// all messages to be sent.
  final requestMessages = [
    systemMessage,
    userMessage,
  ];

// the actual request.
  OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
    model: "gpt-4o-mini",
    responseFormat: {"type": "json_object"},
    messages: requestMessages,
    temperature: 1.0,
    maxTokens: 500,
  );

  // Printing the output to the console

  String contentString = chatCompletion.choices[0].message.content.toString();
  print(chatCompletion.choices[0].message.content);

  // Extract the JSON part of the string
  final jsonStart = contentString.indexOf('{');
  final jsonEnd = contentString.lastIndexOf('}') + 1;
  final jsonString = contentString.substring(jsonStart, jsonEnd);

  // Parse the JSON string to get the list of bars
  Map<String, dynamic> parsedJson = jsonDecode(jsonString);
  List<String> results = List<String>.from(parsedJson["$values"]);

  // Print the list to the console to verify
  print(results);
  return results;
}
