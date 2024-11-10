import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:transport_app/Navbar.dart'; // Make sure this is the correct import for Navbar or HomePage.

class RewardNotify extends StatefulWidget {
  final String username;
  final String email;

  const RewardNotify({
    required this.username,
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  _RewardNotifyState createState() => _RewardNotifyState();
}

class _RewardNotifyState extends State<RewardNotify> {
  late double points;
  late double co2Saved = 0.36;  // You can replace this with the actual CO2 value

  // These variables will control when to show each text
  bool _showCO2Text = false;
  bool _showPointsText = false;

  @override
  void initState() {
    super.initState();

    // Calculate the CO2 saved and points based on the emission value
    points = 100 - ((co2Saved * 0.27) * 100);

    // Delayed to show the CO2 saved text first
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _showCO2Text = true;  // Show CO2 text after 1 second
      });
    });

    // Delayed to show the points text after the CO2 saved text
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showPointsText = true;  // Show points text after 3 seconds
      });
    });

    // Navigate to HomePage after 6 seconds
    Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Navbar(
            username: widget.username,
            email: widget.email,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 16, 25),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 19, 16, 25),
        foregroundColor: Colors.white70,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Center align the content vertically
          crossAxisAlignment: CrossAxisAlignment.center,  // Center align the content horizontally
          children: [
            // Lottie animation in the center
            Lottie.asset(
              'assets/gift.json', // Path to your Lottie animation file
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10), // Space between animation and text
            // Display saved CO2 message
            AnimatedOpacity(
              opacity: _showCO2Text ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Text(
                'You saved $co2Saved grams of CO2!',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 170, 170, 170),
                  fontFamily: 'Sans',
                ),
              ),
            ),
            SizedBox(height: 30), // Space between the CO2 and points messages
            // Display points message with a custom color and animation
            AnimatedOpacity(
              opacity: _showPointsText ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Text(
                'You gained ${points.toStringAsFixed(2)} points! Keep it up!',
                style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 250, 30, 78), // Points text color
                  fontFamily: 'Sans',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
