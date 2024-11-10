import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:transport_app/google-services-api.dart';
import 'package:transport_app/Screens/Map.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String email;

  const HomePage({required this.username, required this.email, Key? key})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GooglePlacesService _placesService = GooglePlacesService();
  final GoogleGeoCodeService _geoCodeService = GoogleGeoCodeService();
  List<String> _srcSuggestions = [];
  List<String> _destSuggestions = [];
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  void _onTextChanged(String input, bool isSource) async {
    try {
      final suggestions = await _placesService.getPlaceSuggestions(input);
      setState(() {
        if (isSource) {
          _srcSuggestions = suggestions;
        } else {
          _destSuggestions = suggestions;
        }
      });
    } catch (e) {
      print('Error fetching suggestions: $e');
    }
  }

  void _navigateToMap() async {
    final source = _sourceController.text;
    final destination = _destinationController.text;

    if (source.isEmpty || destination.isEmpty) {
      print('Error: Source or Destination is empty');
      return;
    }

    try {
      final sourceCoords = await _geoCodeService.getGeoCode(source);
      final destCoords = await _geoCodeService.getGeoCode(destination);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(
            sourceLatLng: LatLng(sourceCoords['lat'], sourceCoords['lng']),
            destinationLatLng: LatLng(destCoords['lat'], destCoords['lng']),
          ),
        ),
      );
    } catch (e) {
      print('Error fetching geocode: $e');
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color.fromARGB(255, 19, 16, 25),
    resizeToAvoidBottomInset: true, // Ensure the page resizes when the keyboard is up
    body: SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Hello ${widget.username}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sans',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.email,
                    style: TextStyle(
                      color: Color.fromARGB(255, 157, 157, 157),
                      fontSize: 18,
                      fontFamily: 'Sans',
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Journey Points',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Sans',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _sourceController,
                    onChanged: (value) {
                      _onTextChanged(value, true);
                    },
                    decoration: InputDecoration(
                      hintText: 'Choose a Source',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 157, 157, 157),
                        fontSize: 18,
                        fontFamily: 'Sans',
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 37, 31, 50),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Sans',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _destinationController,
                    onChanged: (value) {
                      _onTextChanged(value, false);
                    },
                    decoration: InputDecoration(
                      hintText: 'Choose a Destination',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 157, 157, 157),
                        fontSize: 18,
                        fontFamily: 'Sans',
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 37, 31, 50),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Sans',
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _navigateToMap,
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 250, 30, 78),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Center(
                        child: Text(
                          'Search',
                          style: TextStyle(
                            fontFamily: 'Sans',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Stats & Leaderboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Sans',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        height: MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 37, 31, 50),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Carbon Footprint Saved',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontFamily: 'Sans',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '150 kg CO2',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 250, 30, 78),
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  fontFamily: 'Sans',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        height: MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 37, 31, 50),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Badges Achieved',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontFamily: 'Sans',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '23 / 52',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 250, 30, 78),
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  fontFamily: 'Sans',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Suggestion lists for source and destination
          if (_srcSuggestions.isNotEmpty) _buildSourceSuggestionList(),
          if (_destSuggestions.isNotEmpty) _buildDestSuggestionList(),
        ],
      ),
    ),
  );
}



  Widget _buildSourceSuggestionList() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.28, // Adjust based on your layout
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.only(left: 12, right: 12),
        height: 200,
        color: Color.fromARGB(255, 66, 66, 66),
        child: ListView.builder(
          itemCount: _srcSuggestions.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                _srcSuggestions[index],
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Sans',
                ),
              ),
              onTap: () {
                _sourceController.text = _srcSuggestions[index];
                setState(() {
                  _srcSuggestions.clear();
                });
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildDestSuggestionList() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.34, // Adjust based on your layout
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.only(left: 12, right: 12),
        height: 200,
        color: Color.fromARGB(255, 66, 66, 66),
        child: ListView.builder(
          itemCount: _destSuggestions.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                _destSuggestions[index],
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Sans',
                ),
              ),
              onTap: () {
                _destinationController.text = _destSuggestions[index];
                setState(() {
                  _destSuggestions.clear();
                });
              },
            );
          },
        ),
      ),
    );
  }
}
