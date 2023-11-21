import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const AnswerButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class QAndABox extends StatelessWidget {
  final String question;
  final List<String> answers;

  const QAndABox({
    super.key,
    required this.question,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(question),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        color: Colors.grey[400], // TEMPORARY, DELETE OR CHANGE COLOR LATER
        child: ListView.builder(
          itemCount: answers.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10.0),
              child: AnswerButton(
                onTap: () {
                  // Handle button tap
                },
                text: answers[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
