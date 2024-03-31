class SurveyData {
  static List<Map<String, dynamic>> getQuestions() {
    return [
      {
        'question': "Pick you start time and end time for your itinerary.",
      },
      {
        'question': 'What is your search radius?',
      },
      {
        'question': 'What type of activity would you like to do?',
        'answers': [
          'bar',
          'club',
          'food',
          'outdoor activity',
          'indoor activity',
        ],
      }
    ];
  }
}
