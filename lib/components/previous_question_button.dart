import 'package:flutter/material.dart';

class PreviousQuestionButton extends StatelessWidget {
  const PreviousQuestionButton({Key? key, required this.previousQuestion}) : super(key: key);
  final VoidCallback previousQuestion;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter, // Aligns the children at the bottom center
      children: [
        GestureDetector(
          onTap: previousQuestion,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(12),
            child: const Text(
              "Previous Question",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}