import 'package:cpsc_362_project/components/my_button.dart';
import 'package:cpsc_362_project/components/next_question_button.dart';
import 'package:cpsc_362_project/components/previous_question_button.dart';
import 'package:cpsc_362_project/pages/app_pages/home_page.dart';
import 'package:cpsc_362_project/pages/app_pages/page_directory.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../components/survery_buttons.dart';
import 'gpt.dart';
import 'survey_data.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  bool isAnswered = false;

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await _geolocatorPlatform.getCurrentPosition();
    print(position.toString());
    return position;
  }

  List<dynamic> selectedValues = [];
  final List<Widget> questionPages = [];

  int _currentQuestionIndex = 0;
  int pageIndex = 0;

  var radiusList = [1, 2, 3, 4, 5, 10, 20];
  var radius = 1;
  var isSelected = List<bool>.filled(5, false);

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  void _showTimePicker(bool isStartTime) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        if (isStartTime) {
          startTime = selectedTime;
          print(isAnswered.toString());
        } else {
          endTime = selectedTime;
        }
      });
    }
    if (startTime != null && endTime != null) {
      isAnswered = true;
    }
  }

  void nextQuestion() {
    setState(() {
      if (_currentQuestionIndex == 3 &&
          pageIndex < questionPages.length &&
          isAnswered == true) {
        // Handle the next question button within case 3
        pageIndex++;
        isAnswered = false;
      } else if (_currentQuestionIndex < 4 && isAnswered == true) {
        pageIndex = 0; // Reset pageIndex when moving to a new main question
        _currentQuestionIndex++;
        isAnswered = false;
      } else if (isAnswered == false) {
        wrongCredentialMessage("Please answer the prompt before you continue");
      }
      print("Question pages length ${questionPages.length}");
      print("Page index $pageIndex");
      print("Question index $_currentQuestionIndex");
      print("get question ${SurveyData.getQuestions().length}");
      print(isAnswered.toString());
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
    final question = SurveyData.getQuestions()[_currentQuestionIndex];

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
            startTime != null
                ? 'Selected Start Time: ${startTime!.format(context)}'
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
            endTime != null
                ? 'Selected End Time: ${endTime!.format(context)}'
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
              value: radius,
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
                  isAnswered = true;
                  _determinePosition();
                  radius = value!;
                });
              },
              items: radiusList.map<DropdownMenuItem<int>>((int value) {
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
