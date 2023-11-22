//UI for share calendar button and gesture detection for tap
import 'package:flutter/material.dart';

class CalendarButton extends StatelessWidget {

  final Function()? onTap;

  const CalendarButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),

            child: const Center(
              child: Text(
                "Share Calendar",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
        )
    );
  }
}
