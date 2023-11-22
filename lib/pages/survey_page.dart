import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cpsc_362_project/components/q_and_a_box.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {

  QAndAInput input = QAndAInput(
      question: "This is a very long question this is a very long question this is a very long question?",
      answers: ["Q1 Answer 1","Q1 Answer 2","Q1 Answer 3", "Q1 Answer 4"]);

  // false by default, reset flag if generating new survey
  bool lastQuestion = false;

  // generate next question
  void generateNextQAndA(final int index) {
    // set lastQuestion flag to TRUE if already generated last question
    // output question and answer to data file
    // generate new QAndAInput and replace input object with new question and answer

    // below is just example of usage DO NOT USE IN FINAL CODE
    print(input.answers[index]);

    if (input.question == "This is long question number 2?") {
      lastQuestion = true;
    }
    input.question = "This is long question number 2?";
    input.answers = ["Q2 Answer 1","Q2 Answer 2","Q2 Answer 3"];
    // end example
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Survey'),
      ),
      body:
        (lastQuestion == false) ? qAndAColumn() : endSurvey(),
    );
  }

  Widget qAndAColumn() {
    return Column( children: [
      Container(
        height: 90.0,
        margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        alignment: Alignment.center,
        // color: Colors.grey, // TEMPORARY DELETE LATER
        child: Text(
          input.question,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
          // color: Colors.blue, // TEMPORARY DELETE LATER
          alignment: Alignment.center,
          child: ListView.builder(
            itemCount: input.answers.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(10.0),
                child: AnswerButton(
                  onTap: () {
                    setState(() {
                      generateNextQAndA(index);
                    });
                  },
                  text: input.answers[index],
                ),
              );
            },
          ),
        ),
      ),],
    );
  }

  Widget endSurvey() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
        Container(
          margin: const EdgeInsets.only(left: 45.0, right: 45.0, bottom: 20.0),
          child: Center(
            child: Text(
              'New options have been generated for you!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 65.0),
          height: 65.0,
          alignment: Alignment.center,
          child: AnswerButton(
            onTap: () {
              Navigator.pop(context);
              },
            text: "Awesome!",
          ),
        ),],
      ),
    );
  }
}