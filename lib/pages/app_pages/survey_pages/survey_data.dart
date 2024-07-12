class SurveyData {
  static List<Map<String, dynamic>> getQuestions() {
    return [
      {
        'time': "Pick your start time and end time for your itinerary.",
      },
      {
        'radius': 'What is your search radius?',
      },
      {
        'activity': 'What type of activity would you like to do?',
        'answers': [
          'bar',
          'club',
          'food',
          'outdoor activity',
          'indoor activity',
        ],
      },
      {
        'question': "",
      }
    ];
  }
}
