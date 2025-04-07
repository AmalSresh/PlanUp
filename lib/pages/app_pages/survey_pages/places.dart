import 'package:dio/dio.dart';

import '../../../main.dart';
import 'env.dart';

final apiKey = Env.PLACES_KEY;
const lat = 33.860995;
const long = -117.792358;

Future<List<String>> searchPlaces(String keyword) async {
  final dio = Dio();
  final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

  final parameters = {
    'location': '$lat,$long',
    'radius': '${Globals.Radius}',
    'keyword': keyword,
    'key': apiKey,
    'open_now': true,
  };

  try {
    final response = await dio.get(url, queryParameters: parameters);
    final results = response.data['results'] as List;

    // Filter by distance and extract name
    final filteredNames =
        results.take(5).map((result) => result['name'].toString()).toList();
    print(filteredNames);
    return filteredNames;
  } catch (e) {
    print('Error searching nearby places: $e');
    return [];
  }
}
