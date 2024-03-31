import 'package:cpsc_362_project/components/next_question_button.dart';
import 'package:cpsc_362_project/components/previous_question_button.dart';
import 'package:flutter/material.dart';

import 'survey_data.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  int _currentQuestionIndex = 0;
  var list = [1, 2, 3, 4, 5, 10, 20];
  var dropdownValue = 1;

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
    if (_currentQuestionIndex == SurveyData.getQuestions().length - 1) {
      return;
    } else {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex == 0) {
      return;
    } else {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final questions = SurveyData.getQuestions();
    final question = questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Questions'),
      ),
      body: ListView.builder(
        itemCount: 1, // We only display one question at a time
        itemBuilder: (context, index) {
          switch (_currentQuestionIndex) {
            case 0:
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      question['question'],
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
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _startTime != null
                        ? 'Selected Start Time: ${_startTime!.format(context)}'
                        : '',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => _showTimePicker(false),
                    child: Text('Select End Time'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _endTime != null
                        ? 'Selected End Time: ${_endTime!.format(context)}'
                        : '',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              );
            case 1:
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      question['question'],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
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
                        color: Colors.deepPurple,
                        fontSize: 50,
                      ),
                      underline: Container(
                        height: 5,
                        color: Colors.deepPurpleAccent,
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
            // Add more cases for other question indices if needed
            default:
              return SizedBox.shrink(); // Handle default case
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
            SizedBox(width: 10), // Ad
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
