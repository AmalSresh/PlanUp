import 'package:flutter/material.dart';
import 'package:cpsc_362_project/components/q_and_a_box.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {

  final String tQuestion = "hi";
  final List<String> tAnswerList = ["1","2","3"];

  // generate question
  void generateQ() {

  }

  @override
  Widget build(BuildContext context) {
    return QAndABox(question: tQuestion, answers: tAnswerList);
  }
}