import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  final String question;
  final Function(bool isAnswered, String question, TimeOfDay? startTime,
      TimeOfDay? endTime) onTimeSelected;

  const TimePickerWidget({
    Key? key,
    required this.question,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
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
        } else {
          endTime = selectedTime;
        }
        // Call the callback function to notify the parent
        widget.onTimeSelected(
          startTime != null && endTime != null,
          widget.question, // Pass the question parameter here
          startTime,
          endTime,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            widget.question,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: () => _showTimePicker(true),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
          child: const Text('Select Start Time'),
        ),
        const SizedBox(height: 20),
        Text(
          startTime != null
              ? 'Selected Start Time: ${startTime!.format(context)}'
              : '',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _showTimePicker(false),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
          child: const Text('Select End Time'),
        ),
        const SizedBox(height: 20),
        Text(
          endTime != null
              ? 'Selected End Time: ${endTime!.format(context)}'
              : '',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
