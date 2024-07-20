import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:math' show atan2, cos, pi, sin, sqrt;

class MapViewStart extends StatefulWidget {
  final String source;
  final String destination;

  const MapViewStart({required this.source, required this.destination, Key? key}) : super(key: key);

  @override
  State<MapViewStart> createState() => _MapViewStartState();
}

class _MapViewStartState extends State<MapViewStart> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _sourceLatLng;
  LatLng? _destinationLatLng;
  double? _distanceInMeters;

  @override
  void initState() {
    super.initState();
    _getLatLngForLocations();
  }

  Future<void> _getLatLngForLocations() async {
    try {
      final sourceLocation = await locationFromAddress(widget.source);
      final destinationLocation = await locationFromAddress(widget.destination);

      if (sourceLocation.isNotEmpty && destinationLocation.isNotEmpty) {
        setState(() {
          _sourceLatLng = LatLng(sourceLocation[0].latitude, sourceLocation[0].longitude);
          _destinationLatLng = LatLng(destinationLocation[0].latitude, destinationLocation[0].longitude);

          if (_sourceLatLng != null && _destinationLatLng != null) {
            _distanceInMeters = _calculateDistance(_sourceLatLng!, _destinationLatLng!);
          } else {
            print('Error: One or both locations are null');
          }
        });
      } else {
        print('Error: Invalid address or location not found');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _distanceInMeters = null;
      });
    }
  }

  double _calculateDistance(LatLng source, LatLng destination) {
    const double R = 6371e3; // Radius of the Earth in meters
    final double lat1 = source.latitude * pi / 180;
    final double lat2 = destination.latitude * pi / 180;
    final double deltaLat = (destination.latitude - source.latitude) * pi / 180;
    final double deltaLon = (destination.longitude - source.longitude) * pi / 180;

    final double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(lat1) * cos(lat2) *
        sin(deltaLon / 2) * sin(deltaLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c; 
  }

  @override
  Widget build(BuildContext context) {
    if (_sourceLatLng == null || _destinationLatLng == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Map View'),
          backgroundColor: Color.fromARGB(255, 19, 16, 25),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
        backgroundColor: Color.fromARGB(255, 19, 16, 25),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _sourceLatLng!,
              zoom: 10,
            ),
            markers: {
              Marker(
                markerId: MarkerId('source'),
                position: _sourceLatLng!,
                infoWindow: InfoWindow(title: 'Source'),
              ),
              Marker(
                markerId: MarkerId('destination'),
                position: _destinationLatLng!,
                infoWindow: InfoWindow(title: 'Destination'),
              ),
            },
            polylines: {
              Polyline(
                polylineId: PolylineId('route'),
                points: [_sourceLatLng!, _destinationLatLng!],
                color: Colors.blue,
                width: 5,
              ),
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Text(
                _distanceInMeters == null 
                  ? 'Distance: Calculating...'
                  : 'Distance: ${_distanceInMeters?.toStringAsFixed(2)} meters',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
