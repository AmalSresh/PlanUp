import 'package:cpsc_362_project/pages/survey_page.dart';
import 'package:flutter/material.dart';
import 'package:cpsc_362_project/components/location_card.dart';
import 'package:cpsc_362_project/components/calendar_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  void generateCardsCallback(int index) {
    _homePageState?.generateCards(index);
  }
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
        backgroundColor: Colors.blue,
        title: const Text("Home Page"),
      ),
      body: (surveyIndex != -1) ? placesColumn() : defaultHomePageText(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
          FloatingActionButton.large(
            backgroundColor: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SurveyPage(
                    generateCardsCallback: widget.generateCardsCallback,
                  ),
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

  Widget placesColumn() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: title.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10.0),
              child: LocationCard(
                title: title[index],
                subtitle: subtitle[index],
                time: time[index],
              ),
            );
          },
        ),
    );
  }

  Widget defaultHomePageText() {
    return Center(
      child: Text(
        "Take the quick survey to generate an itinerary!",
        textAlign: TextAlign.center,
        style:  TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey.withOpacity(0.7),
        ),
      ),
    );
  }

  void generateCards(int i) {
    switch(i) {
      case(0): // outdoor activity
        title = ["Hillcrest Park", "Fullerton Arboretum", "Downtown Fullerton", "Discovery Cube Orange County", "Anaheim Packing District", "Laguna Lake Park"];
        subtitle = ["Breakfast and exploration", "Visit", "Lunch", "Explore", "Early dinner", "Stroll around"];
        time = ["8:00 am - 10:00 am", "10:30 am - 12:00pm", "12:30 pm - 2:00 pm", "2:30 pm - 4:30 pm", "5:00 pm - 6:30 pm", "7:00 pm - 8:00 pm"];
        break;
      case(1): // entertainment
        title = ["Downtown Fullerton", "Fullerton Museum Center", "Anaheim Packing District", "Camelot Golfland", "Brea Mall", "Laguna Lake Park"];
        subtitle = ["Breakfast and exploration", "Visit", "Lunch", "Fun", "Early dinner and shopping", "Relaxing walk and dessert"];
        time = ["8:00 am - 10:00 am", "10:30 am - 12:00pm", "12:30 pm - 2:00 pm", "2:30 pm - 4:30 pm", "5:00 pm - 6:30 pm", "7:00 pm - 8:00 pm"];
        break;
      case(2): // family attractions
        title = ["Downtown Fullerton", "Fullerton Museum Center", "Anaheim Packing District", "Camelot Golfland", "Brea Mall", "Laguna Lake Park"];
        subtitle = ["Breakfast and exploration", "Visit", "Lunch", "Fun", "Early dinner and shopping", "Relaxing walk and dessert"];
        time = ["8:00 am - 10:00 am", "10:30 am - 12:00pm", "12:30 pm - 2:00 pm", "2:30 pm - 4:30 pm", "5:00 pm - 6:30 pm", "7:00 pm - 8:00 pm"];
        break;
      case(3): // historical locations
        title = ["Downtown Fullerton", "Fullerton Museum Center", "Anaheim Packing District", "Camelot Golfland", "Brea Mall", "Laguna Lake Park"];
        subtitle = ["Breakfast and exploration", "Visit", "Lunch", "Fun", "Early dinner and shopping", "Relaxing walk and dessert"];
        time = ["8:00 am - 10:00 am", "10:30 am - 12:00pm", "12:30 pm - 2:00 pm", "2:30 pm - 4:30 pm", "5:00 pm - 6:30 pm", "7:00 pm - 8:00 pm"];
        break;
      default:
    }
    setState(() {
      surveyIndex = i;
    });
  }

  void clearItinerary() {
    setState(() {
      surveyIndex = -1;
    });
  }
}
