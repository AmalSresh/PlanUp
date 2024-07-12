import 'package:cpsc_362_project/pages/app_pages/survey_pages/survey_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  // void generateCardsCallback(int index) {
  //   _homePageState?.generateCards(index);
  // }
}

_HomePageState? _homePageState;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _homePageState = this;
  }

  late List<String> title;
  late List<String> subtitle;
  late List<String> time;

  int surveyIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blue,
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: 10,
      ),
      floatingActionButton: Row(
        //alignment: WrapAlignment.spaceEvenly,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 30,
          ),
          FloatingActionButton.large(
            backgroundColor: Colors.blue,
            onPressed: () {
              clearItinerary();
            },
            child: const Text(
              'Clear Current Itinerary',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 185),
          FloatingActionButton.large(
            backgroundColor: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SurveyPage(),
                ),
              );
            },
            child: const Text(
              'Take Quick Survey',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget defaultHomePageText() {
    return Center(
      child: Text(
        "Take the quick survey to generate an itinerary!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey.withOpacity(0.7),
        ),
      ),
    );
  }

  void clearItinerary() {
    setState(() {
      surveyIndex = -1;
    });
  }
}
