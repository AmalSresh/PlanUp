import 'package:cpsc_362_project/pages/app_pages/survey_pages/survey_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

_HomePageState? _homePageState;

class _HomePageState extends State<HomePage> {
  List<String> selectedOptionsList = [];
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
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            child: surveyIndex == -1
                ? defaultHomePageText()
                : ListView.builder(
                    itemCount: selectedOptionsList.length,
                    itemBuilder: (context, index) {
                      final option = selectedOptionsList[index];
                      return Card(
                        color: Colors.blue,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                            option,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.large(
              heroTag: 'FABone',
              backgroundColor: Colors.blue,
              onPressed: () {
                clearItinerary();
              },
              child: const Text(
                'Clear\nItinerary',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            FloatingActionButton.large(
              heroTag: 'FABtwo',
              backgroundColor: Colors.blue,
              onPressed: () async {
                final returnedOptions = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurveyPage()),
                );

                if (returnedOptions != null && returnedOptions is Map) {
                  setState(() {
                    selectedOptionsList =
                        List<String>.from(returnedOptions['options']);
                    TimeOfDay? startTime = returnedOptions['start'];
                    TimeOfDay? endTime = returnedOptions['end'];

                    surveyIndex = 0;
                  });
                }
              },
              child: const Text(
                'Quick\nSurvey',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
      selectedOptionsList.clear();
    });
  }
}
