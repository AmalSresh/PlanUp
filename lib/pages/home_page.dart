import 'package:cpsc_362_project/pages/survey_page.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Home Page"),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 10),
            CalendarButton(
              onTap: () {
                //Share Calendar Logic
              }
            )
          ]
        )
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SurveyPage()),
          );
        },
        child: const Text(
          'Take Quick Survey',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          )
        ),
      ),
    );
  }

  Widget placesColumn() {
    return Center(
        child: Column(

      ),
    );
  }
}
