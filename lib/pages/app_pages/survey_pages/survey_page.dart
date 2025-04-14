import 'package:cpsc_362_project/components/dropdown.dart';
import 'package:cpsc_362_project/components/my_button.dart';
import 'package:cpsc_362_project/components/next_question_button.dart';
import 'package:cpsc_362_project/components/previous_question_button.dart';
import 'package:cpsc_362_project/pages/app_pages/survey_pages/places.dart';
import 'package:cpsc_362_project/pages/app_pages/survey_pages/sub-page.dart';
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

class selection {
  final List<String> options = [];
  TimeOfDay? start;
  TimeOfDay? end;

  void saveTime(TimeOfDay? startTime, TimeOfDay? endTime) {
    start = startTime;
    end = endTime;
  }

  void add(String option) {
    if (options.length < 5) {
      options.add(option);
      print("these are the options stored: ${options}");
    } else {
      print("error, you are trying to add more than 5 options");
    }
  }

  void clear() {
    options.clear();
  }
}

class _SurveyPageState extends State<SurveyPage> {
  bool isAnswered = false;
  late selection selectedOptions;

  @override
  void initState() {
    super.initState();
    selectedOptions = selection();
    selectedOptions.clear();
  }

  //list of selected activity types
  List<dynamic> selectedValues = [];

  //list of question pages that are
  int subQuestion = 0;

  int currentQuestionIndex = 0;
  int pageIndex = 0;

  //Search radius distance options
  final List<int> radiusList = [1, 2, 3, 4, 5, 10, 20];

  var isSelected = List<bool>.filled(5, false);

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex == 3) {
        // At dynamic question phase
        if (pageIndex < subQuestion - 1 && isAnswered == true) {
          // Go to next sub-question
          pageIndex++;
          isAnswered = false;
        } else if (pageIndex == subQuestion - 1 && isAnswered == true) {
          // Finished all dynamic pages
          currentQuestionIndex++;
          pageIndex = 0;
          isAnswered = false;
        } else {
          wrongCredentialMessage(
              "Please answer the prompt before you continue");
        }
      } else if (currentQuestionIndex < 4 && isAnswered == true) {
        // For non-dynamic questions
        pageIndex = 0;
        currentQuestionIndex++;
        isAnswered = false;
      } else if (isAnswered == false) {
        wrongCredentialMessage("Please answer the prompt before you continue");
      }
      print("Question pages length ${subQuestion}");
      print("Page index $pageIndex");
      print("Question index $currentQuestionIndex");
      print(isAnswered.toString());
    });
  }

  void previousQuestion() {
    setState(() {
      if (pageIndex > 0) {
        pageIndex--;
      } else if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
        pageIndex =
            subQuestion - 1; // Set to the last page of the previous question
      }
    });
  }

  void redirect(List<String> subOptions, String option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubPage(
          options: subOptions,
          mainOption: option,
          selectedOptions: selectedOptions,
        ),
      ),
    );
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
                selectedOptions.saveTime(startTime, endTime);
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
              scroll: false,
              onTap: (values) {
                setState(() {
                  selectedValues = values;
                  print(selectedValues);
                  if (selectedValues.isNotEmpty) {
                    isAnswered = true;
                    subQuestion = selectedValues.length;
                  }
                });
              },
            ),
          ),
        ],
      );
    }

    Widget buildDynamicQuestions() {
      if (pageIndex >= selectedValues.length) {
        //currentQuestionIndex++;
      }

      String value = selectedValues[pageIndex];

      return FutureBuilder<List<String>>(
        future: rec(question['$value'], value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
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
                      SurveyButtons(
                        onTap: () async {
                          final subOptions = await searchPlaces(optOne);
                          redirect(subOptions, optOne);
                          setState(() {
                            isAnswered = true;
                            if (subOptions.isNotEmpty) {
                              nextQuestion();
                            }
                          });
                        },
                        text: optOne,
                      ),
                      const SizedBox(height: 20),
                      SurveyButtons(
                        onTap: () async {
                          final subOptions = await searchPlaces(optTwo);
                          const CircularProgressIndicator();
                          redirect(subOptions, optTwo);
                          setState(() {
                            isAnswered = true;
                            if (subOptions.isNotEmpty) {
                              nextQuestion();
                            }
                          });
                        },
                        text: optTwo,
                      ),
                      const SizedBox(height: 20),
                      SurveyButtons(
                        onTap: () async {
                          final subOptions = await searchPlaces(optThree);
                          redirect(subOptions, optThree);
                          setState(() {
                            isAnswered = true;
                            if (subOptions.isNotEmpty) {
                              nextQuestion();
                            }
                          });
                        },
                        text: optThree,
                      ),
                      const SizedBox(height: 20),
                      SurveyButtons(
                        onTap: () async {
                          final subOptions = await searchPlaces(optFour);
                          redirect(subOptions, optFour);
                          setState(() {
                            isAnswered = true;
                            if (subOptions.isNotEmpty) {
                              nextQuestion();
                            }
                          });
                        },
                        text: optFour,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Text("No data available");
          }
        },
      );
    }

    Widget endPage() {
      return Center(
        child: Column(
          children: [
            const Text('All questions completed!'),
            const SizedBox(
              height: 10,
            ),
            MyButton(
                onTap: () {
                  Navigator.pop(context, {
                    'options': selectedOptions.options,
                    'start': selectedOptions.start,
                    'end': selectedOptions.end,
                  });
                },
                text: "Go Home")
          ],
        ),
      );
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
              return endPage();
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
