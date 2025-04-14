import 'package:cpsc_362_project/pages/app_pages/survey_pages/survey_page.dart';
import 'package:flutter/material.dart';

import '../../../components/survery_buttons.dart';

class SubPage extends StatelessWidget {
  final String mainOption;
  final List<String> options;
  final selection selectedOptions;

  const SubPage({
    required this.mainOption,
    required this.options,
    required this.selectedOptions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Options for $mainOption")),
      body: options.isEmpty
          ? Center(
              child: SurveyButtons(
                onTap: () {
                  Navigator.pop(context);
                },
                text: "Go Back",
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: options.map((option) {
                  return SurveyButtons(
                    text: option,
                    onTap: () {
                      selectedOptions.add(option);
                      Navigator.pop(context, option);
                    },
                  );
                }).toList(),
              ),
            ),
    );
  }
}
