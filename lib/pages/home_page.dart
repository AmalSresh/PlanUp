import 'package:flutter/material.dart';
import 'package:cpsc_362_project/components/calendar_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  //share calendar method
  //  void shareCalendar() async{
  //    //show loading circle
  //    showDialog(
  //      context: context,
  //      builder: (context) {
  //        return const Center(
  //          child: CircularProgressIndicator(),
  //        );
  //      }
  //      );
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          CalendarButton(
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
