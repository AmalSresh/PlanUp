import 'package:cpsc_362_project/components/my_button.dart';
import 'package:cpsc_362_project/components/next_question_button.dart';
import 'package:cpsc_362_project/components/previous_question_button.dart';
import 'package:cpsc_362_project/pages/app_pages/home_page.dart';
import 'package:cpsc_362_project/pages/app_pages/page_directory.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import 'survey_data.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  List<dynamic> selectedValues = [];
  final List<Widget> questionPages = [];

  int _currentQuestionIndex = 0;
  int pageIndex = 0;

  var list = [1, 2, 3, 4, 5, 10, 20];
  var dropdownValue = 1;
  var isSelected = List<bool>.filled(5, false);

  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  void _showTimePicker(bool isStartTime) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = selectedTime;
        } else {
          _endTime = selectedTime;
        }
      });
    }
  }

  void nextQuestion() {
    setState(() {
      if (_currentQuestionIndex == 3 && pageIndex < questionPages.length) {
        // Handle the next question button within case 3
        pageIndex++;
      } else {
        if (_currentQuestionIndex < SurveyData.getQuestions().length - 1) {
          pageIndex = 0; // Reset pageIndex when moving to a new main question
          _currentQuestionIndex++;
        }
      }
      print("Question pages length ${questionPages.length}");
      print("Page index $pageIndex");
      print("Question index $_currentQuestionIndex");
      print("get question ${SurveyData.getQuestions().length}");
    });
  }

  void previousQuestion() {
    setState(() {
      if (pageIndex > 0) {
        pageIndex--;
      } else if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
        pageIndex = questionPages.length -
            1; // Set to the last page of the previous question
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions = SurveyData.getQuestions();
    if (_currentQuestionIndex >= questions.length) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          toolbarHeight: 70,
          title: const Text(
            'Questions',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('All dynamic questions completed!'),
              const SizedBox(
                height: 10,
              ),
              MyButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const PageDirectory();
                        },
                      ),
                    );
                  },
                  text: "Go Home")
            ],
          ),
        ),
      );
    }

    final question = questions[_currentQuestionIndex];
    Widget buildTimePickerQuestion(Map<String, dynamic> question) {
      return Column(
        children: [
          ListTile(
            title: Text(
              question['time'],
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () => _showTimePicker(true),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
            child: const Text('Select Start Time'),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            _startTime != null
                ? 'Selected Start Time: ${_startTime!.format(context)}'
                : '',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => _showTimePicker(false),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
            child: const Text('Select End Time'),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            _endTime != null
                ? 'Selected End Time: ${_endTime!.format(context)}'
                : '',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      );
    }

    Widget buildDropdownQuestion(Map<String, dynamic> question) {
      return Column(
        children: [
          ListTile(
            title: Text(
              question['radius'],
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 100,
            height: 80,
            child: DropdownButton<int>(
              value: dropdownValue,
              icon: const Icon(
                Icons.arrow_downward,
                size: 40,
                color: Colors.blue,
              ),
              elevation: 26,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 50,
              ),
              underline: Container(
                height: 5,
                color: Colors.blue,
              ),
              onChanged: (int? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: list.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
          ),
        ],
      );
    }

    Widget buildMultiSelectQuestion(Map<String, dynamic> question) {
      var answers = List<String>.from(question['answers'] ?? []);
      var multiSelectItems = answers
          .map((answer) => MultiSelectItem<String>(answer, answer))
          .toList();
      return Column(
        children: [
          ListTile(
            title: Text(
              question['activity'],
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 1000,
            width: 400,
            child: MultiSelectChipField(
              items: multiSelectItems,
              initialValue: const [],
              title: const Text("OPTIONS"),
              headerColor: Colors.blue.withOpacity(0.5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 1.8),
              ),
              selectedChipColor: Colors.blue.withOpacity(0.5),
              selectedTextStyle: TextStyle(color: Colors.blue[800]),
              onTap: (values) {
                setState(() {
                  selectedValues = values;
                  print(selectedValues);
                });
              },
            ),
          ),
        ],
      );
    }

    Widget buildDynamicQuestions() {
      questionPages.clear();
      for (var value in selectedValues) {
        questionPages.add(
          Column(
            children: [
              ListTile(
                title: Text(
                  "What type of $value would you like?",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Add your question widgets here
            ],
          ),
        );
      }
      if (pageIndex < questionPages.length) {
        return questionPages[pageIndex];
      } else {
        return Center(
          child: Column(
            children: [
              const Text('All  DY questions completed!'),
              const SizedBox(
                height: 10,
              ),
              MyButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomePage();
                        },
                      ),
                    );
                  },
                  text: "Go Home")
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        toolbarHeight: 70,
        title: const Text(
          'Questions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 1, // We only display one question at a time
        itemBuilder: (context, index) {
          switch (_currentQuestionIndex) {
            case 0:
              return buildTimePickerQuestion(question);
            case 1:
              return buildDropdownQuestion(question);
            case 2:
              return buildMultiSelectQuestion(question);
            case 3:
              return buildDynamicQuestions();
            case 4:
              return Center(
                child: Column(
                  children: [
                    const Text('All questions completed!'),
                    const SizedBox(
                      height: 10,
                    ),
                    MyButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const HomePage();
                              },
                            ),
                          );
                        },
                        text: "Go Home")
                  ],
                ),
              ); // }
            default:
              return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: PreviousQuestionButton(
                previousQuestion: previousQuestion,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: NextQuestionButton(
                nextQuestion: nextQuestion,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
