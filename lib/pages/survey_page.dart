import 'dart:convert';
import 'dart:math';

import 'package:dart_openai/dart_openai.dart';
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
  Future<void> generateNextQAndA(final int index) async {
    // set lastQuestion flag to TRUE if already generated last question
    // output question and answer to data file
    // generate new QAndAInput and replace input object with new question and answer

    // below is just example of usage DO NOT USE IN FINAL CODE
    print(input.answers[index]);

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


    if (input.question == "This is long question number 2?") {
      lastQuestion = true;

      // Generate itinerary using OpenAI after the specific question is answered
      try {
        String itinerary = await generateItineraryUsingOpenAI(destination, input.answers, apiData);
        print(itinerary); // Handle the generated itinerary as needed
      } catch (e) {
        print('Error in generating itinerary: $e');
      }
    }
    input.question = "What time would you like your itinerary to be?";
    input.answers = ["7 AM to 10 PM","10 AM to 10 PM","8 AM to 8 PM"];
    // end example
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

  Widget qAndAColumn() {
    return Column( children: [
      Container(
        height: 90.0,
        margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        alignment: Alignment.center,
        // color: Colors.grey, // TEMPORARY DELETE LATER
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
          // color: Colors.blue, // TEMPORARY DELETE LATER
          alignment: Alignment.center,
          child: ListView.builder(
            itemCount: input.answers.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(10.0),
                child: AnswerButton(
                  onTap: () {
                    setState(() {
                      generateNextQAndA(index);
                    });
                  },
                  text: input.answers[index],
                ),
              );
            },
          ),
        ),
      ),],
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
              'New options have been generated for you!',
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