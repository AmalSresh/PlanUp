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
          'snack',
          'outdoor activity',
          'indoor activity',
        ],
      },
      {
        'bar':
            'in a list of 4 that has no formatting, introduction, or sentences except for commas, give me random bar types searchable on maps. The list should be called bar',
        'club':
            "in a list of 4 that has no formatting, introduction, or sentences except for commas, give me random casual dancing clubs types searchable on maps.The list should be called club",
        'food':
            "in a list of 4 that has no formatting, introduction, or sentences except for commas, give me random lunch and dinner cuisines searchable on maps. The list should be called food",
        'snack':
            "in a list of 4 that has no formatting, introduction, or sentences except for commas, give me random snack store types and dessert stores searchable on maps. The list should be called snack",
        'outdoor activity':
            "in a list of 4 that has no formatting, introduction, or sentences except for commas, give me random outdoor activities searchable on maps. The list should be called outdoor activity",
        'indoor activity':
            "in a list of 4 that has no formatting, introduction, or sentences except for commas, give me random indoor activities searchable on maps. The list should be called indoor activity",
      }
    ];
  }
}
