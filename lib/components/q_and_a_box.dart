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
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class QAndABox extends StatefulWidget {
  final String question;
  final List<String> answers;
  final Function()? onTap;

  const QAndABox({
    super.key,
    required this.question,
    required this.answers,
    required this.onTap,
  });

  @override
  State<QAndABox> createState() => _QAndABoxState();
}

class _QAndABoxState extends State<QAndABox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Survey'),
      ),
      body: Column(
        children: [
          Container(
            height: 90.0,
            margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            alignment: Alignment.center,
            // color: Colors.grey, // TEMPORARY DELETE LATER
            child: Text(
              widget.question,
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
                itemCount: widget.answers.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    child: AnswerButton(
                      onTap: widget.onTap,
                      text: widget.answers[index],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
