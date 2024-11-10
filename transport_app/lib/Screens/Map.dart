import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transport_app/google-services-api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  final LatLng sourceLatLng;
  final LatLng destinationLatLng;

  const MapScreen({
    required this.sourceLatLng,
    required this.destinationLatLng,
    Key? key,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  List<List<LatLng>> _routes = [];
  List<LatLng> _selectedRoute = [];
  bool _isLoading = true;
  String distance = '';
  String duration = '';
  String fare = '';
  String carbonEmission = '';
  String _selectedMode = 'driving';
  int _optimalRouteIndex = 0; // Index of the most optimal route (example logic)

  @override
  void initState() {
    super.initState();
    _fetchAllData();
  }

  Future<void> _fetchAllData() async {
    setState(() {
      _isLoading = true;
      _resetData();
    });

    try {
      await Future.wait([
        _fetchRoutes(),
        _fetchDistanceAndCarbonEmission(),
      ]);
    } catch (e) {
      print('Error fetching data: ${e.toString()}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _resetData() {
    _routes = [];
    _selectedRoute = [];
    distance = '';
    duration = '';
    fare = '';
    carbonEmission = '';
  }

  Future<void> _fetchRoutes() async {
    final directionService = GoogleDirectionService();
    try {
      final userSelectionObject = {
        'src':
            '${widget.sourceLatLng.latitude},${widget.sourceLatLng.longitude}',
        'destn':
            '${widget.destinationLatLng.latitude},${widget.destinationLatLng.longitude}',
        'mode': _selectedMode,
      };
      final routes = await directionService.getDirections(userSelectionObject);
      setState(() {
        _routes = routes;
        _selectedRoute = _routes.isNotEmpty ? _routes[_optimalRouteIndex] : [];
      });
    } catch (e) {
      print('Error fetching routes: ${e.toString()}');
    }
  }

  Future<void> _fetchDistanceAndCarbonEmission() async {
    final distanceMatrixService = GoogleDistanceMatrixService();
    try {
      final requestBody = {
        'src': [
          {
            'lat': widget.sourceLatLng.latitude,
            'lng': widget.sourceLatLng.longitude
          }
        ],
        'destn': [
          {
            'lat': widget.destinationLatLng.latitude,
            'lng': widget.destinationLatLng.longitude
          }
        ],
        'mode': _selectedMode
      };

      final response =
          await distanceMatrixService.getDistanceMatrix(requestBody);
      if (response['status'] == 'OK' &&
          response['rows'][0]['elements'][0]['status'] == 'OK') {
        setState(() {
          distance = response['rows'][0]['elements'][0]['distance']['text'];
          duration = response['rows'][0]['elements'][0]['duration']['text'];
          if (_selectedMode == 'transit') {
            fare = response['rows'][0]['elements'][0]['fare']?['text'] ?? 'N/A';
          }
        });
        await _fetchCarbonEmission(
            response['rows'][0]['elements'][0]['distance']['value']);
      } else {
        _setDefaultValues();
      }
    } catch (e) {
      print('Error fetching distance matrix: ${e.toString()}');
      _setDefaultValues();
    }
  }

  void _setDefaultValues() {
    setState(() {
      distance = 'N/A';
      duration = 'N/A';
      fare = 'N/A';
      carbonEmission = 'N/A';
    });
  }

  Future<void> _fetchCarbonEmission(int distanceInMeters) async {
    final apiUrl = 'http://192.168.0.109:5000/api/carbon-emission/';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(
            {'distance': distanceInMeters / 1000, 'mode': _selectedMode}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          carbonEmission = '${data['data']} kg';
        });
      } else {
        setState(() {
          carbonEmission = 'N/A';
        });
      }
    } catch (e) {
      print('Error fetching carbon emission: ${e.toString()}');
      setState(() {
        carbonEmission = 'N/A';
      });
    }
  }

  void _onRouteSelected(int index) {
    setState(() {
      _selectedRoute = _routes[index];
    });
  }

  Color _getPolylineColor(int index) {
    return index == _optimalRouteIndex ? Colors.green : Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Route Map')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ['driving', 'walking', 'transit'].map((mode) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedMode = mode;
                        });
                        _fetchAllData();
                      },
                      child: Text(mode.capitalizeFirst),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedMode == mode
                            ? _getButtonColor(mode)
                            : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: GoogleMap(
                    onMapCreated: (controller) => _mapController = controller,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        (widget.sourceLatLng.latitude +
                                widget.destinationLatLng.latitude) /
                            2,
                        (widget.sourceLatLng.longitude +
                                widget.destinationLatLng.longitude) /
                            2,
                      ),
                      zoom: 12,
                    ),
                    markers: _createMarkers(),
                    polylines: _createPolylines(),
                  ),
                ),
                _buildInfoCard(),
              ],
            ),
    );
  }

  Set<Marker> _createMarkers() {
    return {
      Marker(
          markerId: MarkerId('source'),
          position: widget.sourceLatLng,
          infoWindow: InfoWindow(title: 'Source')),
      Marker(
          markerId: MarkerId('destination'),
          position: widget.destinationLatLng,
          infoWindow: InfoWindow(title: 'Destination')),
    };
  }

  Set<Polyline> _createPolylines() {
    if (_routes.isEmpty) return {};
    return _routes.asMap().entries.map((entry) {
      int index = entry.key;
      List<LatLng> route = entry.value;
      return Polyline(
        polylineId: PolylineId('route_$index'),
        color: _getPolylineColor(index),
        width: index == _optimalRouteIndex ? 8 : 4,
        points: route,
        onTap: () => _onRouteSelected(index),
      );
    }).toSet();
  }

  Widget _buildInfoCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Distance: $distance'),
              Text('Duration: $duration'),
              if (_selectedMode == 'transit') Text('Fare: $fare'),
              Text('Carbon Emission: $carbonEmission'),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String get capitalizeFirst =>
      this.length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
}

Color _getButtonColor(String mode) {
  switch (mode) {
    case 'walking':
      return Colors.green;
    case 'transit':
      return Colors.red;
    default:
      return Colors.blue;
  }
}
