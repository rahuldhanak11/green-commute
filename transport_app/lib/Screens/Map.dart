import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transport_app/google-services-api.dart';

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
  List<LatLng> _routeCoordinates = [];
  bool _isLoading = true;
  String distance = '';
  String duration = '';
  String fare = '';
  String _selectedMode = 'driving';

  @override
  void initState() {
    super.initState();
    _fetchRouteAndDistanceMatrix();
  }

  Future<void> _fetchRouteAndDistanceMatrix() async {
    setState(() {
      _isLoading = true;
      _routeCoordinates = [];
      distance = '';
      duration = '';
      fare = '';
    });

    await _fetchRoute();
    await _fetchDistanceMatrix();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchRoute() async {
    final directionService = GoogleDirectionService();
    try {
      final userSelectionObject = {
        'src':
            '${widget.sourceLatLng.latitude},${widget.sourceLatLng.longitude}',
        'destn':
            '${widget.destinationLatLng.latitude},${widget.destinationLatLng.longitude}',
        'mode': _selectedMode,
      };

      final coordinates =
          await directionService.getDirections(userSelectionObject);
      print('Fetched Coordinates: $coordinates'); // Debugging
      setState(() {
        _routeCoordinates = coordinates;
      });
    } catch (e) {
      print('Error fetching route: $e');
    }
  }

  Future<void> _fetchDistanceMatrix() async {
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
      print('Distance Matrix Response: $response'); // Debugging
      setState(() {
        if (response['status'] == 'OK' &&
            response['rows'][0]['elements'][0]['status'] == 'OK') {
          distance = response['rows'][0]['elements'][0]['distance']['text'];
          duration = response['rows'][0]['elements'][0]['duration']['text'];
          if (_selectedMode == 'transit') {
            fare = response['rows'][0]['elements'][0]['fare']?['text'] ?? 'N/A';
          }
        } else {
          distance = 'N/A';
          duration = 'N/A';
          fare = 'N/A';
        }
      });
    } catch (e) {
      print('Error fetching distance matrix: $e');
      setState(() {
        distance = 'N/A';
        duration = 'N/A';
        fare = 'N/A';
      });
    }
  }

  Color _getPolylineColor() {
    switch (_selectedMode) {
      case 'walking':
        return Colors.green;
      case 'transit':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Map'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedMode = 'driving';
                        });
                        _fetchRouteAndDistanceMatrix();
                      },
                      child: Text('Driving'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedMode == 'driving'
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedMode = 'walking';
                        });
                        _fetchRouteAndDistanceMatrix();
                      },
                      child: Text('Walking'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedMode == 'walking'
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedMode = 'transit';
                        });
                        _fetchRouteAndDistanceMatrix();
                      },
                      child: Text('Transit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedMode == 'transit'
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      _mapController = controller;
                      final bounds = LatLngBounds(
                        southwest: LatLng(
                          min(widget.sourceLatLng.latitude,
                              widget.destinationLatLng.latitude),
                          min(widget.sourceLatLng.longitude,
                              widget.destinationLatLng.longitude),
                        ),
                        northeast: LatLng(
                          max(widget.sourceLatLng.latitude,
                              widget.destinationLatLng.latitude),
                          max(widget.sourceLatLng.longitude,
                              widget.destinationLatLng.longitude),
                        ),
                      );
                      _mapController.animateCamera(
                          CameraUpdate.newLatLngBounds(bounds, 50));
                    },
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
                    markers: {
                      Marker(
                        markerId: MarkerId('source'),
                        position: widget.sourceLatLng,
                        infoWindow: InfoWindow(title: 'Source'),
                      ),
                      Marker(
                        markerId: MarkerId('destination'),
                        position: widget.destinationLatLng,
                        infoWindow: InfoWindow(title: 'Destination'),
                      ),
                    },
                    polylines: {
                      if (_routeCoordinates.isNotEmpty)
                        Polyline(
                          polylineId: PolylineId('route'),
                          color: _getPolylineColor(),
                          width: 10,
                          points: _routeCoordinates,
                        ),
                    },
                  ),
                ),
                Padding(
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
