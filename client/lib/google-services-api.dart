import 'dart:convert';
import 'package:http/http.dart' as http;

class GooglePlacesService {
  final String apiUrl = 'http://localhost:5000/api/map/place-autocomplete'; // Replace with your server URL

  Future<List<String>> getPlaceSuggestions(String input) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'input': input}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return List<String>.from(data['predictions'].map((x) => x['description']));
    } else {
      throw Exception('Failed to load place suggestions');
    }
  }
}
