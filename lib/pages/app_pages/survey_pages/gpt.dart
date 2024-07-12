import 'package:dart_openai/dart_openai.dart';

import 'env.dart';

Future<void> rec() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.KEY;

  // Start using!
  final completion = await OpenAI.instance.completion.create(
    model: "davinci-002",
    prompt: "Are dogs cute?",
  );

  // Printing the output to the console
  print(completion.choices[0].text);
}
