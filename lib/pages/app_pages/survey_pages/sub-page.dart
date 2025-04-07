import 'package:flutter/material.dart';

import '../../../components/survery_buttons.dart';

class SubPage extends StatelessWidget {
  final String mainOption;
  final List<String> options;

  const SubPage({
    required this.mainOption,
    required this.options,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Options for $mainOption")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: options.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SurveryButtons(
              text: options[index],
              onTap: () {
                // Handle deeper navigation or final result
                print("Selected: ${options[index]}");
              },
            ),
          );
        },
      ),
    );
  }
}
