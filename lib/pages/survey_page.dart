import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cpsc_362_project/components/q_and_a_box.dart';
import 'package:http/http.dart' as http;

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {

  QAndAInput input = QAndAInput(
      question: "What do you want to prioritize?",
      answers: ["Outdoor Activity","Entertainment","Family Attractions", "Historical Locations"]);

  // false by default, reset flag if generating new survey
  bool lastQuestion = false;
  bool isLoading = false;

  // Add your Google API Key here
  final String apiKey = 'AIzaSyAOsViyztEmFWV3qOV_fGNn86qTlQKps8U';
  final String openAIKey = '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';



  Future<List<dynamic>> queryGooglePlaces(String query) async {
    final url = Uri.parse('https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return data['results'];
      }
    }
    throw Exception('Failed to load places');
  }

  // generate next question
  Future<void> outputAnswer(final int index) async {
    print("start outputAnswer function");
    // set lastQuestion flag to TRUE if already generated last question
    // output question and answer to data file
    // generate new QAndAInput and replace input object with new question and answer

    setState(() {
      isLoading = true;
    });

    // do something with given user answer
    print("Output from question is: ${input.answers[index]}");

    List<dynamic> apiData = [];
    // Example: Set destination and landmark based on user input
    String destination = "Fullerton"; // Replace with actual destination from user input


    // Prepare the queries
    List<String> queries = [
      "family attractions in $destination",
      "parks in $destination",
      "nightlife in $destination",
      "museums in $destination",
      "restaurants near $destination"
    ];

    // Iterate over the queries and fetch results
    for (String query in queries) {
      try {
        List<dynamic> results = await queryGooglePlaces(query);

        // Append the results to apiData
        apiData.addAll(results);

      } catch (e) {
        print('Error occurred while fetching places: $e');
      }
    }

    // not sure when this block will be used
    if (false) {
      // Generate itinerary using OpenAI after the specific question is answered
      try {
        String itinerary = await generateItineraryUsingOpenAI(destination, input.answers, apiData);
        print(itinerary); // Handle the generated itinerary as needed
      } catch (e) {
        print('Error in generating itinerary: $e');
      }
    }

    setState(() {
      isLoading = false;
    });

    print("end outputAnswer function");
  }

  // the input.question and input.answer should somehow be updated before this point
  void nextQAndA() {
    print("start nextQAndA function");

    // something should indicate when the last question is at this point
    if (input.question == "What time would you like your itinerary to be?") {
      lastQuestion = true;
    }

    input.question = "What time would you like your itinerary to be?";
    input.answers = ["7 AM to 10 PM","10 AM to 10 PM","8 AM to 8 PM"];

    print("end nextQAndA function");
  }

  Future<String> generateItineraryUsingOpenAI(String destination, List<String> userSpecifications, List<dynamic> apiData) async {
    var aigen = openai(apiKey: openAIKey);

    String prompt = 'Location: $destination 25 mile radius '
        'Specifications for what user wants: ${userSpecifications.join(', ')} '
        'Google Map API data: ${apiData.map((e) => e['name']).join(', ')} '
        'Create an itinerary for the user that would make the most sense that follows the user specifications and list the time slots as well.';

    var response = await aigen.completions.create(prompt: prompt);
    return response.choices.first.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Survey'),
      ),
      body:
        (lastQuestion == false) ? qAndAColumn() : endSurvey(),
    );
  }

  Widget loadingScreen() {
    return isLoading
      ? Container(
        color: Colors.black.withOpacity(0.5),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      )
      : const SizedBox.shrink(); // return an empty SizedBox when not loading
  }

  Widget qAndAColumn() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 90.0,
              margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              alignment: Alignment.center,
              child: Text(
                input.question,
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
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: input.answers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10.0),
                      child: AnswerButton(
                        onTap: () async {
                          await outputAnswer(index);
                          setState(() {
                            nextQAndA();
                          });

                        },
                        text: input.answers[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        loadingScreen(),
      ],
    );
  }


  Widget endSurvey() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
        Container(
          margin: const EdgeInsets.only(left: 45.0, right: 45.0, bottom: 20.0),
          child: Center(
            child: Text(
              '8:00 am - 10:00 am: Breakfast and Exploration at Hillcrest Park \n\n 10:30 am - 12:00 pm: Visit the Fullerton Arboretum \n\n 12:30 pm - 2:00 pm: Lunch at Downtown Fullerton \n\n 2:30 pm - 4:30 pm: Discovery Cube Orange County \n\n 5:00 pm - 6:30 pm: Early Dinner at Anaheim Packing District \n\n 7:00 pm - 8:00 pm: Stroll around Laguna Lake Park',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 65.0),
          height: 65.0,
          alignment: Alignment.center,
          child: AnswerButton(
            onTap: () {
              Navigator.pop(context);
              },
            text: "Awesome!",
          ),
        ),],
      ),
    );
  }

  openai({required String apiKey}) {}
}