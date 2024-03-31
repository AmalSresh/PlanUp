import 'package:flutter/material.dart';

class NextQuestionButton extends StatelessWidget {
  const NextQuestionButton({Key? key, required this.nextQuestion}) : super(key: key);
  final VoidCallback nextQuestion;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight, // Aligns the children at the bottom center
      children: [
        GestureDetector(
          onTap: nextQuestion,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(12),
            child: const Text(
              "Next Question",
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