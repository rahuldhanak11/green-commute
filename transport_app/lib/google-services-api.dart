import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GoogleGeoCodeService {
  final String apiUrl =
      'https://green-commute-9o3s.onrender.com/api/map/geocode'; // Replace with your server URL

  Future<Map<String, dynamic>> getGeoCode(String address) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'address': address}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final latlang = data['results'][0]['geometry']['location'];
      print("'lat': ${latlang['lat']}, 'lng': ${latlang['lng']}");
      return {'lat': latlang['lat'], 'lng': latlang['lng']};
    } else {
      throw Exception('Failed to load geocode');
    }
  }
}

class GooglePlacesService {
  final String apiUrl =
      'https://green-commute-9o3s.onrender.com/api/map/place-autocomplete'; // Replace with your server URL

  Future<List<String>> getPlaceSuggestions(String input) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'input': input}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(
          data['predictions'].map((x) => x['description']));
    } else {
      throw Exception('Failed to load place suggestions');
    }
  }
}

class GoogleDistanceMatrixService {
  final String apiUrl =
      'https://green-commute-9o3s.onrender.com/api/map/distance-matrix'; // Replace with your server URL

  Future<Map<String, dynamic>> getDistanceMatrix(
      Map<String, dynamic> requestBody) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );
    print(requestBody);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load distance matrix');
    }
  }
}

class GoogleReverseGeoCodeService {
  final String apiUrl =
      'https://green-commute-9o3s.onrender.com/api/map/reverse-geocode'; // Replace with your server URL

  Future<Map<String, dynamic>> getReverseGeoCode(
      Map<String, dynamic> requestBody) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load GeoCode Address');
    }
  }
}

class GoogleDirectionService {
  final String apiUrl =
      'https://green-commute-9o3s.onrender.com/api/map/directions'; // Replace with your server URL

  List<LatLng> decodePolyline(String encoded) {
    final List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      final nLat = (lat / 1E5).toDouble();
      final nLng = (lng / 1E5).toDouble();
      poly.add(LatLng(nLat, nLng));
    }

    return poly;
  }

  Future<List<List<LatLng>>> getDirections(
      Map<String, dynamic> requestBody) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Create a list to hold multiple routes
      final List<List<LatLng>> routesCoordinates = [];

      if (data['status'] == 'OK') {
        final routes = data['routes'];
        for (var route in routes) {
          final List<LatLng> routeCoordinates = [];
          final steps = route['legs'][0]['steps'];

          // Decode and add the coordinates for each step
          for (var step in steps) {
            final polyline = step['polyline']['points'];
            routeCoordinates.addAll(decodePolyline(polyline));
          }

          // Add the current route's coordinates to the list of all routes
          routesCoordinates.add(routeCoordinates);
        }
      }

      return routesCoordinates;
    } else {
      throw Exception('Failed to load directions');
    }
  }
}
