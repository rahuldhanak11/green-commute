import 'package:flutter/material.dart';

class MapViewStart extends StatefulWidget {
  const MapViewStart({super.key});

  @override
  State<MapViewStart> createState() => _MapViewStartState();
}

class _MapViewStartState extends State<MapViewStart> {
  String? _selectedVehicle; 

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final mapViewHeight = screenHeight * 0.4; 

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 16, 25),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20), 
            Text(
              'Select Your Vehicle',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sans',
              ),
            ),
            const SizedBox(height: 20), 
            Container(
              width: double.infinity,
              height: mapViewHeight, 
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 37, 31, 50),
                borderRadius: BorderRadius.circular(9.0),
              ),
              child: Center(
                child: Text(
                  'Map View Here',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Sans',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), 
            Expanded(
              child: Column(
                children: [
                  vehicleOption(
                    icon: Icons.directions_car,
                    vehicleName: 'Car',
                    carbonFootprint: '10 kg CO2',
                    isSelected: _selectedVehicle == 'Car',
                    onTap: () {
                      setState(() {
                        _selectedVehicle = 'Car';
                      });
                    },
                  ),
                  vehicleOption(
                    icon: Icons.directions_bike,
                    vehicleName: 'Bicycle',
                    carbonFootprint: '0 kg CO2',
                    isSelected: _selectedVehicle == 'Bicycle',
                    onTap: () {
                      setState(() {
                        _selectedVehicle = 'Bicycle';
                      });
                    },
                  ),
                  vehicleOption(
                    icon: Icons.train,
                    vehicleName: 'Train',
                    carbonFootprint: '5 kg CO2',
                    isSelected: _selectedVehicle == 'Train',
                    onTap: () {
                      setState(() {
                        _selectedVehicle = 'Train';
                      });
                    },
                  ),
                  vehicleOption(
                    icon: Icons.directions_walk,
                    vehicleName: 'Walking',
                    carbonFootprint: '0 kg CO2',
                    isSelected: _selectedVehicle == 'Walking',
                    onTap: () {
                      setState(() {
                        _selectedVehicle = 'Walking';
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), 
            GestureDetector(
              onTap: () {
                print(_selectedVehicle);
              },
              child: Container(
                width: double.infinity,
                height: 45, 
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 250, 30, 78),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Center(
                  child: Text(
                    'Confirm Selection',
                    style: TextStyle(
                      fontFamily: 'Sans',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget vehicleOption({
    required IconData icon,
    required String vehicleName,
    required String carbonFootprint,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 37, 31, 50),
          borderRadius: BorderRadius.circular(9.0),
          border: Border.all(
            color: isSelected
                ? Color.fromARGB(255, 250, 30, 78) // Pink color
                : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30.0, color: Colors.white),
            SizedBox(width: 16.0),
            Expanded(
              child: Text(
                vehicleName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: 'Sans',
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Row(
              children: [
                Icon(Icons.energy_savings_leaf, size: 20.0, color: Colors.green),
                SizedBox(width: 4.0),
                Text(
                  carbonFootprint,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16.0,
                    fontFamily: 'Sans',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
