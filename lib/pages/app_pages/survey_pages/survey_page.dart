import 'package:cpsc_362_project/components/dropdown.dart';
import 'package:cpsc_362_project/components/my_button.dart';
import 'package:cpsc_362_project/components/next_question_button.dart';
import 'package:cpsc_362_project/components/previous_question_button.dart';
import 'package:cpsc_362_project/pages/app_pages/home_page.dart';
import 'package:cpsc_362_project/pages/app_pages/page_directory.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../components/survery_buttons.dart';
import '../../../components/time_picker.dart';
import 'gpt.dart';
import 'survey_data.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  bool isAnswered = false;

  //list of selected activity types
  List<dynamic> selectedValues = [];

  //list of question pages that are
  final List<Widget> questionPages = [];

  int currentQuestionIndex = 0;
  int pageIndex = 0;

  //Search radius distance options
  final List<int> radiusList = [1, 2, 3, 4, 5, 10, 20];

  var isSelected = List<bool>.filled(5, false);

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex == 3 &&
          pageIndex < questionPages.length &&
          isAnswered == true) {
        // Handle the next question button within case 3
        pageIndex++;
        isAnswered = false;
      } else if (currentQuestionIndex < 4 && isAnswered == true) {
        pageIndex = 0; // Reset pageIndex when moving to a new main question
        currentQuestionIndex++;
        isAnswered = false;
      } else if (isAnswered == false) {
        wrongCredentialMessage("Please answer the prompt before you continue");
      }
      print("Question pages length ${questionPages.length}");
      print("Page index $pageIndex");
      print("Question index $currentQuestionIndex");
      print("get question ${SurveyData.getQuestions().length}");
      print(isAnswered.toString());
    });
  }

  void previousQuestion() {
    setState(() {
      if (pageIndex > 0) {
        pageIndex--;
      } else if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
        pageIndex = questionPages.length -
            1; // Set to the last page of the previous question
      }
    });
  }

  void wrongCredentialMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = SurveyData.getQuestions()[currentQuestionIndex];

    Widget buildTimePickerQuestion(Map<String, dynamic> question) {
      return Column(
        children: [
          TimePickerWidget(
            question: question['time'],
            onTimeSelected: (answered, question, startTime, endTime) {
              setState(() {
                isAnswered = answered;
              });
            },
          ),
        ],
      );
    }

    Widget buildDropdownQuestion(Map<String, dynamic> question) {
      return Column(
        children: [
          DropdownQuestion(
            question: question['radius'],
            selectedRadius: radiusList,
            onSelected: (answered, question, radius) {
              setState(() {
                isAnswered = answered;
              });
            },
          ),
        ],
      );
    }

    Future<List<String>> makeOptions() async {
      var value = selectedValues[pageIndex];
      List<String> results = await rec(question['$value'], value);
      return results;
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
                  if (selectedValues.isNotEmpty) {
                    isAnswered = true;
                  }
                  makeOptions();
                  // rec(question['bar'], 'bar');
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
          FutureBuilder<List<String>>(
            future: makeOptions(), // Call your Future function
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for the future to complete, show a loading indicator
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Handle any errors that occur during the future execution
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // If the future completes successfully, use the data
                var results = snapshot.data!;
                var optOne = results[0];
                var optTwo = results.length > 1 ? results[1] : 'Option 2';
                var optThree = results.length > 2 ? results[2] : 'Option 3';
                var optFour = results.length > 3 ? results[3] : 'Option 4';

                return Column(
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
                      subtitle: Column(
                        children: <Widget>[
                          const SizedBox(height: 50),
                          SurveryButtons(
                            onTap: () {
                              // Action for option 1
                            },
                            text: optOne,
                          ),
                          const SizedBox(height: 20),
                          SurveryButtons(
                            onTap: () {
                              // Action for option 2
                            },
                            text: optTwo,
                          ),
                          const SizedBox(height: 20),
                          SurveryButtons(
                            onTap: () {
                              // Action for option 3
                            },
                            text: optThree,
                          ),
                          const SizedBox(height: 20),
                          SurveryButtons(
                            onTap: () {
                              // Action for option 4
                            },
                            text: optFour,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Text("No data available");
              }
            },
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
                          return const PageDirectory();
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

    // Widget dynamicSubQuestion() {
    //    questionPages.clear();
    //  }

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
          switch (currentQuestionIndex) {
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
